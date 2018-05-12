// set_min_auths and set_gender should have already been set outside.
if (typeof set_min_auths == 'undefined' || typeof set_gender == 'undefined') {
    throw "Failed to define set_min_auths or set_gender before running queries!"
}

use dat

var map2YearMonth = function() {
  var yr = String(this.issued['date-parts'][0][0]);
  var mo = String(this.issued['date-parts'][0][1]);
  var dat_ok = 'author-genders' in this && this['author-genders'].length >= min_authors;
  if (dat_ok && this['author-genders'][0] == gender) {
    var result = 1;
  } else {
    var result = 0;
  };
  emit(yr + '_' + mo, result);
};

var reduceFunc = function(yr_mo, results) {
  return Array.sum(results);
};

db.crossref.mapReduce(
  map2YearMonth,
  reduceFunc,
  {
    out: {replace : "female_first_auth_by_yr_mo_counts_3plus_authors" },
    scope : { gender : set_gender, min_authors : set_min_auths }
    // not using query param because it kills visibility into % progress
  }
)
