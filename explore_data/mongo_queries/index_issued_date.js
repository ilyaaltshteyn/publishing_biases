use dat
// Add index on issued date, on zero-th element of date-parts field (contains an array [year, month, day])
db.crossref.createIndex({'issued.date-parts.0' : 1}, {partialFilterExpression : { 'issued.date-parts.0' : {$exists : true } } } )
