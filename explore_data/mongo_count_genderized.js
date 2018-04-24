use dat
db.crossref.find(
  {$and :
    [
      {'author-genders' : {$exists : false }},
      {'author' : {$exists : true } }
    ]
  }
).count()

