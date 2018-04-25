nohup mongoexport -d dat -c crossref --type=csv --fields issued,subject,author-genders -q '{"$and":[{"author-genders" : {"$exists" : true}},{"type" : "journal-article"},{"issued.date-parts.0.0" : 1990},{"issued.date-parts.0.1" : 1}]}' --out jan1990_gender_results.csv &
