use dat
\\ Count records that have an author but that we have not added an author-genders field to.
db.crossref.find(
  {$and :
    [
      {'author-genders' : {$exists : false }},
      {'author' : {$exists : true } }
    ]
  }
).count()

