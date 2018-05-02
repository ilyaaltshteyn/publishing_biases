// $opts will be passed in here

use dat

// ensure run_queries.sh set vars properly
var xth_auth_undefined = typeof set_xth_auth == 'undefined';
var num_auths_undefined = typeof set_num_auths == 'undefined';
var gender_undefined = typeof set_gender == 'undefined';
var pubtype_undefined = typeof set_pubtype == 'undefined';
var authtypecomparison_undefined = typeof set_auth_count_comparison == 'undefined';
if ( xth_auth_undefined || num_auths_undefined || gender_undefined || pubtype_undefined || authtypecomparison_undefined) {
    throw 'Failed to define one or more required vars before running queries!';
}

var map2year = function() {
  var yr = String(this.issued['date-parts'][0][0]);
  var dat_ok = 'author-genders' in this;

  // Manipulate comparison operator
  // Not ideal way to do this
  if (authcount_comparison == 'ge') {
    var length_ok = this['author-genders'].length >= min_auths;
  } else {
    var length_ok = this['author-genders'].length == min_auths;
  };

  var type_ok = this['type'] == pubtype;
  var gender_ok = this['author-genders'][xth_auth] == gender;
  if (dat_ok && length_ok && type_ok && gender_ok) {
    var result = 1;
  } else {
    var result = 0;
  };
  emit(yr, result);
};

var reduce2count = function(yr_mo, results) {
  return Array.sum(results);
};

var output_coll_name = set_gender + '_' + set_xth_auth + 'th_auth_' + set_pubtype + '_' + set_num_auths + 'or_more_auths_per_yr';

db.crossref.mapReduce(
  map2year,
  reduce2count,
  {
    out: {replace : output_coll_name },
    scope : {
      gender : set_gender,
      min_auths : set_num_auths,
      xth_auth : set_xth_auth,
      pubtype : set_pubtype,
      authcount_comparison : set_auth_count_comparison
    }
    // not using query param because it kills visibility into % progress
  }
)
