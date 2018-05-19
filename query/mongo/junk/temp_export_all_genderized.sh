nohup mongoexport -d dat -c crossref --type=csv --fields issued,subject,author-genders -q '{ "$and" : [{"author-genders" : {"$exists" : true } },{"type" : "journal-article"}]}' --out all_genderized.csv &
nohup mongoexport -d dat -c crossref --type=csv --fields issued,subject,author-genders -q '{"$and":[{"author-genders" : {"$exists" : true}},{"type" : "journal-article"},{"issued.date-parts.0.0" : 1990},{"issued.date-parts.0.1" : 1}]}' --out jan1990_gender_results.csv &

mongoexport -d dat -c male_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out male_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c male_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out male_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c male_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out male_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c male_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out male_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c male_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out male_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c male_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out male_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv


mongoexport -d dat -c female_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out female_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c female_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out female_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c male_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out male_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c male_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out male_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c mostly_female_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out mostly_female_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c mostly_female_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out mostly_female_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c mostly_male_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out mostly_male_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c unknown-code_failure_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out unknown-code_failure_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c unknown-code_failure_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out unknown-code_failure_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c unknown-estimation_failure_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out unknown-estimation_failure_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c unknown-estimation_failure_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out unknown-estimation_failure_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c unknown-initials_only_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out unknown-initials_only_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c unknown-initials_only_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out unknown-initials_only_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c unknown-single_character_name_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out unknown-single_character_name_0th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
mongoexport -d dat -c unknown-single_character_name_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts --type=csv --fields _id,value --out unknown-single_character_name_1th_auth_papers_with_3or_more_authors_by_yr_mo_counts.csv
