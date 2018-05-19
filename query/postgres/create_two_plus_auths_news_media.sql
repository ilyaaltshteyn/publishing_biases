create table temp_newspapers_two_plus_auths as
with newspapers as (
  select * from wiki_citations
  where url in (select url from wiki_citations where value_type = 'newspaper')
)  -- Get distinct urls of news citations that have both a 1st and 2nd author
  select distinct(url)
  from newspapers
  where url in
  (select url
  from newspapers
  where value_type = 'author2' or value_type = 'first2')
  and value_type = 'author1' or value_type = 'first1'
;

create table temp_magazines_two_plus_auths as
with
magazines as (
  select * from wiki_citations
  where url in (select url from wiki_citations where value_type = 'magazine')
)
  select distinct(url)
  from magazines
  where url in
  (select url
  from magazines
  where value_type = 'author2' or value_type = 'first2')
  and value_type = 'author1' or value_type = 'first1'
;

create table temp_news_citations_two_plus_auths as
  select distinct(url)
  from news_citations
  where url in
  (select url
  from news_citations
  where value_type = 'author2' or value_type = 'first2')
  and value_type = 'author1' or value_type = 'first1'
;

create table two_plus_auths_news_media as
select * from temp_newspapers_two_plus_auths
union
select * from temp_magazines_two_plus_auths
union
select * from temp_news_citations_two_plus_auths
;
