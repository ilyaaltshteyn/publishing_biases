// set_min_auths and set_gender should have already been set outside.
var min_auths_undefined = typeof set_min_auths == 'undefined';
var gender_undefined = typeof set_gender == 'undefined';
var xth_auth_undefined = typeof set_xth_auth == 'undefined';
if ( min_auths_undefined || gender_undefined || xth_auth_undefined ) {
    throw "Failed to define one of the required vars before running queries!";
}

use dat

var map2YearMonth = function() {
  var yr = String(this.issued['date-parts'][0][0]);
  var mo = String(this.issued['date-parts'][0][1]);
  var dat_ok = 'author-genders' in this && this['author-genders'].length >= min_auths;
  if (dat_ok && this['author-genders'][xth_auth] == gender) {
    var result = 1;
  } else {
    var result = 0;
  };
  emit(yr + '_' + mo, result);
};

var reduceFunc = function(yr_mo, results) {
  return Array.sum(results);
};

var output_coll_name = set_gender + '_' + set_xth_auth + 'th_auth_papers_with_' + set_min_auths + 'or_more_authors_by_yr_mo_counts';

db.crossref.mapReduce(
  map2YearMonth,
  reduceFunc,
  {
    out: {replace : output_coll_name },
    scope : {
      gender : set_gender,
      min_auths : set_min_auths,
      xth_auth : set_xth_auth
    }
    // not using query param because it kills visibility into % progress
  }
)
