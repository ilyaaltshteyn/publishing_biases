use dat
db.crossref.createIndex({'author-genders' : 1}, {partialFilterExpression : { 'author-genders' : {$exists : true } } } )
