use dat
var mapFunction1 = function() {
                       emit(String(this.issued.date-parts.0.0) + '_' + String(this.issued.date-parts.0.1), this.type);
                   };

var reduceFunction1 = function(d, t) {
                          return t.join('-');
                      };

db.sample.mapReduce(
                     mapFunction1,
                     reduceFunction1,
                     { out: "map_reduce_example" }
                   )

