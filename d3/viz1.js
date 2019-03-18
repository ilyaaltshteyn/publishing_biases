// Base code borrowed from: https://bl.ocks.org/datafunk/8a17b5f476a40a08ed17

var margin = {
        top: 10,
        right: 10,
        bottom: 20,
        left: 30
    },
    width = 990 - margin.left - margin.right,
    height = 400 - margin.top - margin.bottom;

var y = d3.scale.linear()
    .range([height, 0]);

var x = d3.scale.ordinal()
    .rangeRoundBands([0, width], .15);

var xAxisScale = d3.scale.linear()
    .domain([1940, 2017])
    .range([0, width]);

var xAxis = d3.svg.axis()
    .scale(xAxisScale)
    .orient("bottom")
    .tickFormat(d3.format("d"));

var to_percent = function (d) {
  return String(Math.abs(d)*100);
};

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .tickFormat(to_percent)
    .ticks(6)
    .tickSize(0)
    .tickPadding(10);

var svg = d3.select("#chart1").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

d3.csv("data1.csv", type, function(error, data) {
    x.domain(data.map(function(d) {
        return d._id;
    }));
    y.domain([-.42, .42]).nice();

    svg.selectAll(".bar")
        .data(data)
        .enter().append("rect")
        .attr("class", function(d) {

            if (d.proportional_difference < 0){
                return "bar male";
            } else {
                return "bar female";
            }

        })
        .attr("data-yr", function(d){
            return d._id;
        })
        .attr("data-c", function(d){
            return d.proportional_difference;
        })
        .attr("title", function(d){
            return ("title")
        })
        .attr("y", function(d) {

            if (d.proportional_difference > 0){
                return y(d.proportional_difference);
            } else {
                return y(0);
            }

        })
        .attr("x", function(d) {
            return x(d._id);
        })
        .attr("width", x.rangeBand())
        .attr("height", function(d) {
            return Math.abs(y(d.proportional_difference) - y(0));
        })
        .attr("opacity", .6);

    svg.selectAll(".line")
        // .attr("class", "x axis")
        .data(data)
        .enter()
        .append("line")
        .attr("class", function(d) {

            if (d.proportional_difference < 0){
                return "line male";
            } else {
                return "line female";
            }

        })
        .attr("y1", function(d) { return Math.abs(y(d.proportional_difference));})
        .attr("y2", function(d) { return Math.abs(y(d.proportional_difference));})
        .attr("x1", function(d) { return x(d._id); } )
        .attr("x2", function (d) {return x(d._id) + x.rangeBand(); });

    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis);

    svg.append("g")
        .attr("class", "X axis")
        .attr("transform", "translate(" + (margin.left - 6.5) + "," + height + ")")
        .call(xAxis);

    svg.append("g")
        .attr("class", "x axis")
        .append("line")
        .attr("y1", y(0))
        .attr("y2", y(0))
        .attr("x2", width);

    // svg.append("g")
    //     .attr("class", "infowin")
    //     .attr("transform", "translate(50, 5)")
    //     .append("text")
    //     .attr("id", "_yr");

    svg.append("g")
        .attr("class", "infowin")
        .attr("transform", "translate(110, 5)")
        .append("text")
        .attr("id","degrree");

    // annotations
    var l1_height = (height/2) - 20;
    svg.append("g")
        .attr("class", "y axis")
        .append("text")
        .text("% more likely if female")
        .attr("transform", "translate(8, " + l1_height + "), rotate(-90)");

    var l2_height = (height/2) + 118;
    svg.append("g")
        .attr("class", "y axis")
        .append("text")
        .text("% more likely if male")
        .attr("transform", "translate(8, " + l2_height + "), rotate(-90)");

    // Add the title
  	svg.append("text")
      .attr("class", "title_label")
      .attr("x", 0)
      .attr("y", 24)
      .text("Likelihood of being 1st author depends on gender");

    // svg.append("line")
    // 		.attr("x1", x(1961) + 5)
    // 		.attr("y1", y(-.405))
    // 		.attr("x2", x(1961) + 30)
    // 		.attr("y2", y(-.43))
    // 		.attr("id", "dashline");

    svg.append("g")
        .append("text")
        .text("In 1961, a man had a 40% better chance")
        .attr("x", x(1961) + 50)
    		.attr("y", y(-.44))
        .attr("class", "annotation_label");

    svg.append("g")
        .append("text")
        .text("of being first author than a woman.")
        .attr("x", x(1961) + 50)
    		.attr("y", y(-.47))
        .attr("class", "annotation_label");

    var annx3 = x(1983) + 33;
    svg.append("g")
        .append("text")
        .text("At the turn of the century, gender alone no longer")
        .attr("x", annx3)
    		.attr("y", y(.26))
        .attr("class", "annotation_label");

    svg.append("g")
        .append("text")
        .text("affected an author’s chance of being first author.")
        .attr("x", annx3)
        .attr("y", y(.23))
        .attr("class", "annotation_label");

    var curve_path_1 = "M753 108 C 756 111, 765 120, 775 174";
    var curve = svg.append("path")
        .attr("id", "arrow_body")
        .attr("d",curve_path_1)
        .attr("fill","white")
        .attr("stroke","blue")
        .attr("stroke-width",2)
        .attr("marker-end","url(#arrow)");

    var curve_path_2 = "M310 349 C 300 349, 278 349, 274 340";
    var curve = svg.append("path")
        .attr("id", "arrow_body")
        .attr("d",curve_path_2)
        .attr("fill","white")
        .attr("stroke","blue")
        .attr("stroke-width",2)
        .attr("marker-end","url(#arrow)");

});


function type(d) {
    d.proportional_difference = +d.proportional_difference;
    return d;
}
