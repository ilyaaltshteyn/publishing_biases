use dat
// Get just journal articles that have author genders assigned
db.crossref.findOne(
  { $and :
    [
      {'author-genders' : {$exists : true } },
      {'type' : 'journal-article'}
    ]
  },
  {
    'author-genders' : 1,
    'issued' : 1,
    'subject' : 1,
    'author' : 1
  }
)

// db.crossref.find(
//   {$and :
//     [
//       {'author-genders' : {$exists : false }},
//       {'author' : {$exists : true } }
//     ]
//   }
// ).count()


// Get date from date-parts
db.crossref.findOne({'issued.date-parts.0.0' : 2017})

// Get author-genders for a given year and month
db.findOne({'$and' :
  [
    {'author-genders' : {'$exists' : true}},
    {'type' : 'journal-article'}
    {'issued.date-parts.0.0' : 2017},
    {'issued.date-parts.0.1' : 1},
  ]
}, {'author-genders' : 1})
