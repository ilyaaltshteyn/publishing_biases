use dat

var set_min_auths = 1;

var map2YearMonth = function() {
  var yr = String(this.issued['date-parts'][0][0]);
  var mo = String(this.issued['date-parts'][0][1]);
  if (this['author-genders'][0] == gender) {
    var result = this['author-genders'].length;
  } else {
    var result = this['author-genders'].length;
  };
  emit(yr + '_' + mo, result);
};

var reduceFunc = function(yr_mo, results) {
  return Math.min(results);
};

// Set query for minimal gender-authors array length
var q = {};
var k = 'author-genders.' + String(set_min_auths - 1);
var v = {'$exists' : true};
q[k] = v;

db.crossref.mapReduce(
  map2YearMonth,
  reduceFunc,
  {
    out: {replace : "test_mr" },
    scope : { gender : 'female', min_authors : set_min_auths },
    query :
    { '$and' :
      [ {'author-genders' : {'$exists' : true} }, q ]
    },
    limit : 100
  }
)
