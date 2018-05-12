use dat

var mapperFunc = function() {
  emit(this['type'], 1);
};

var reduceFunc = function(t, results) {
  return Array.sum(results);
};

db.crossref.mapReduce(
  mapperFunc,
  reduceFunc,
  {
    out: { replace : 'counts_by_type' },
  }
)
