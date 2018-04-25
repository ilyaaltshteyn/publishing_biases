use dat
var mapFunction1 = function() {
  var yr = String(this.issued['date-parts'][0][0])
  var mo = String(this.issued['date-parts'][0][1])
  if (this['author-gender'].length > 1 && this['author-gender'][1] == 'female') {
    var first_auth_female = 1
  } else {
    var first_auth_female = 0
  }
  emit(yr + '_' + mo, first_auth_female);
};

var reduceFunction1 = function(yr_mo, f) {
  return Array.sum(f);
};

db.crossref.mapReduce(
  { query :
    {'author-genders' :
      {'$exists' : true}
    }
  }
  mapFunction1,
  reduceFunction1,
  { out: "female_second_auth_by_yr_mo_counts" }
)
