use dat
// Get just journal articles that have author genders assigned
db.crossref.findOne(
  { $and :
    [
      {'author-genders' : {$exists : true } },
      {'type' : 'journal-article'}
    ]
  },
  {'author-genders' : 1, 'issued' : 1, 'subject' : 1, 'author' : 1}
)

// db.crossref.find(
//   {$and :
//     [
//       {'author-genders' : {$exists : false }},
//       {'author' : {$exists : true } }
//     ]
//   }
// ).count()
