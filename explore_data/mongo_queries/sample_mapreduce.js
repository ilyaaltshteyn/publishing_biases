use dat
var mapFunction1 = function() {
  var yr = String(this.issued['date-parts'][0][0])
  var mo = String(this.issued['date-parts'][0][0])
  if (this['author-gender'] == 'female') {
    var first_auth_female = 1
  } else {
    var first_auth_female = 0
  }
  emit(yr + '_' + mo, first_auth_female);
};

var reduceFunction1 = function(yr_mo, f) {
  return Array.sum(f);
};

db.sample.mapReduce(
                     mapFunction1,
                     reduceFunction1,
                     { out: "female_first_author_by_yr_mo_counts" }
                   )
