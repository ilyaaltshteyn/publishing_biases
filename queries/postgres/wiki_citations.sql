-- Citations from top 50 news sites based on Alexa rating
create table news_citations as
( select * from
  (select * from wiki_citations where value_type in
    ('author', 'author1', 'author2', 'author3', 'author4', 'author5', 'author6',
     'title', 'url', 'first', 'first1', 'first2', 'first3', 'first4', 'first5',
     'first6', 'date', 'year')
   ) auths
  where url ilike '%cnn.com%'
  or url ilike '%nytimes.com%'
  or url ilike '%theguardian.com%'
  or url ilike '%indiatimes.com%'
  or url ilike '%washingtonpost.com%'
  or url ilike '%forbes.com%'
  or url ilike '%foxnews.com%'
  or url ilike '%huffingtonpost.com%'
  or url ilike '%timesofindia.indiatimes.com%'
  or url ilike '%usatoday.com%'
  or url ilike '%bloomberg.com%'
  or url ilike '%wsj.com%'
  or url ilike '%cnbc.com%'
  or url ilike '%reuters.com%'
  or url ilike '%time.com%'
  or url ilike '%drudgereport.com%'
  or url ilike '%nypost.com%'
  or url ilike '%cbsnews.com%'
  or url ilike '%chron.com%'
  or url ilike '%usnews.com%'
  or url ilike '%thehill.com%'
  or url ilike '%theatlantic.com%'
  or url ilike '%nbcnews.com%'
  or url ilike '%economictimes.indiatimes.com%'
  or url ilike '%news.com.au%'
  or url ilike '%chinadaily.com.cn%'
  or url ilike '%latimes.com%'
  or url ilike '%abcnews.go.com%'
  or url ilike '%dw.com%'
  or url ilike '%variety.com%'
  or url ilike '%thehindu.com%'
  or url ilike '%thedailybeast.com%'
  or url ilike '%indianexpress.com%'
  or url ilike '%sfgate.com%'
  or url ilike '%hollywoodreporter.com%'
  or url ilike '%nationalgeographic.com%'
  or url ilike '%newsweek.com%'
  or url ilike '%chicagotribune.com%'
  or url ilike '%euronews.com%'
  or url ilike '%hindustantimes.com%'
);

-- Get urls that have a 2nd author
select count(distinct(url))
from news_citations
where url in
(select url
from news_citations
where value_type = 'author2' or value_type = 'first2')
and value_type = 'author1' or value_type = 'first1';
-- Output: 44,754

-- How many news_citations do we have with value_type = author?
select count(*) from news_citations where value_type='author';
-- Output: 131,708

-- How many news_citations do we have where value_type is author and contains 'and', ',' etc?
select count(*) from
(select * from news_citations where value_type='author') auths
where value like '% and %' or value like '%,%' or value like '%;%';
-- Output: 6,461

-- How many urls do we have with value_type = 'newspaper'?
select count(distinct(url)) from wiki_citations where value_type = 'newspaper';
-- Output: 643,894
select count(distinct(url)) from wiki_citations where value_type = 'magazine';
-- Output: 27,098
-- Compared to: how many urls do we have with value_type = 'newspaper' in news_citations?
select count(distinct(url)) from news_citations;
-- Output: 655,112


-- Create a new table of urls only.
-- Each url should belong to a paper that has both a 2nd and a first author.
create table two_plus_auths_news_media as
with newspapers as (
  select * from wiki_citations
  where url in (select url from wiki_citations where value_type = 'newspaper')
),
magazines as (
  select * from wiki_citations
  where url in (select url from wiki_citations where value_type = 'magazine')
)
  -- Get distinct urls of news citations that have both a 1st and 2nd author
  select distinct(url)
  from news_citations
  where url in
  (select url
  from news_citations
  where value_type = 'author2' or value_type = 'first2')
  and value_type = 'author1' or value_type = 'first1'
  union
  select distinct(url)
  from newspapers
  where url in
  (select url
  from newspapers
  where value_type = 'author2' or value_type = 'first2')
  and value_type = 'author1' or value_type = 'first1'
  union
  select distinct(url)
  from magazines
  where url in
  (select url
  from magazines
  where value_type = 'author2' or value_type = 'first2')
  and value_type = 'author1' or value_type = 'first1'
;
