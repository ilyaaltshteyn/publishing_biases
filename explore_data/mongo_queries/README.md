# Mongo queries to retrieve data

## MapReduce
| Query file | Query description |
| --- | --- |
| `mr_female_first_auth_by_yr_mo_counts.js` | MapReduce. Generates collection `female_first_auth_by_yr_mo_counts`, which is the count of papers by year_month that have author-genders list of length > 0 and have "female" as first author gender.|
| `mr_female_second_auth_by_yr_mo_counts.js` | MapReduce. Generates collection `female_second_auth_by_yr_mo_counts`, which is the count of papers by year_month that have author-genders list of length > 0 and have "female" as second author gender |
