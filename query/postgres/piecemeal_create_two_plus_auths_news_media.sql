-- Get just the newspapers data
create table temp_newspapers as (
  select * from wiki_citations
  where url in (select url from wiki_citations where value_type = 'newspaper')
);

-- Get just the newspapers with 2nd author info
create table temp_newspapers_with_2nd_auth as (
select url
from temp_newspapers
where value_type = 'author2' or value_type = 'first2'
);

-- Get just the newspapers that have 2nd author info AND 1st author info
create table temp_newspapers_with_2nd_and_1st_auths as (
select distinct(url)
from temp_newspapers
where url in
(select url from temp_newspapers_with_2nd_auth)
and value_type = 'author1' or value_type = 'first1'
);

-- See how many there are
Select count(*) from temp_newspapers_with_2nd_and_1st_auths;
--Output: 11,406


-- Now repeat for magazines
-- Get just the magazines data
create table temp_magazines as (
  select * from wiki_citations
  where url in (select url from wiki_citations where value_type = 'magazine')
);

-- Get just the magazines with 2nd author info
create table temp_magazines_with_2nd_auth as (
select url
from temp_magazines
where value_type = 'author2' or value_type = 'first2'
);

-- Get just the magazines that have 2nd author info AND 1st author info
create table temp_magazines_with_2nd_and_1st_auths as (
select distinct(url)
from temp_magazines
where url in
(select url from temp_magazines_with_2nd_auth)
and value_type = 'author1' or value_type = 'first1'
);

-- See how many there are
Select count(*) from temp_magazines_with_2nd_and_1st_auths;
--Output: 741


-- Now repeat for news_citations
create table temp_news_citations_with_2nd_auth as (
select url
from news_citations
where value_type = 'author2' or value_type = 'first2'
);

create table temp_news_citations_with_2nd_and_1st_auths as (
  select distinct(url)
  from news_citations
  where url in
  (select url from temp_news_citations_with_2nd_auth)
  and value_type = 'author1' or value_type = 'first1'
);
