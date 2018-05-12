use dat
// Add index
db.crossref.createIndex({'type' : 1}, {partialFilterExpression : { 'type' : {$exists : true } } } )
