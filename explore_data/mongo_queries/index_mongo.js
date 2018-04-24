use dat
\\ Add an index on author genders
db.crossref.createIndex({'author-genders' : 1}, {partialFilterExpression : { 'author-genders' : {$exists : true } } } )
