-- ## Alter tables ##

-- Create years column in pct_data
begin;
alter table pct_data add column year int;
update pct_data set year = extract(year from date);
commit;

-- Create max auth count column in rawinventor
begin;
alter table rawinventor add column auth_count int;
update rawinventor set auth_count = max(sequence) over(partition by patent_id);
commit;


-- ## Run queries ##

-- Get counts of male and female names, grouped by year and author count
create table counts_by_gender_year_authcount as
(select year, count(*) count_authorships, auth_count, author_gender, sequence
from
  (select
      patent_id, author_gender, name_first, sequence,
      max(sequence) over(partition by patent_id) auth_count
    from rawinventor
  ) as auths
  left join
    (select patent_id, year from pct_data) as pct_data
  on auths.patent_id = pct_data.patent_id
group by year, auth_count, author_gender, sequence);

-- Get counts by gender, year and author count for target papers.
copy
(select *
from counts_by_gender_year_authcount
where
  author_gender in ('male', 'female')
  and year > 1979
  and year < 2017
  and auth_count::int > 1)
to '/Users/ilya/code/publishing_biases/analyze/analyses/patent/counts_by_gender_year_authcount.csv'
with csv delimiter ',' header;
