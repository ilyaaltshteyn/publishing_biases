use dat

var mapFunction1 = function() {
  var yr = String(this.issued['date-parts'][0][0]);
  var mo = String(this.issued['date-parts'][0][1]);
  var dat_ok = 'author-genders' in this && this['author-genders'].length > 1;
  if (dat_ok && this['author-genders'][1] == 'female') {
    var target_gender = 1;
  } else {
    var target_gender = 0;
  };
  emit(yr + '_' + mo, target_gender);
};

var reduceFunction1 = function(yr_mo, gender) {
  return Array.sum(gender);
};

db.crossref.mapReduce(
  mapFunction1,
  reduceFunction1,
  { out: "female_second_auth_by_yr_mo_counts" },
  { query :
    { '$and' :
      [
        {'author-genders' : {'$exists' : true} },
        {'author-genders.1' : {'$exists' : true} }
      ]
    }
  }
)
