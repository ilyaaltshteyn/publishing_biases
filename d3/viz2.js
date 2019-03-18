var margin2 = {top:40, right:0, bottom:20, left:0},
    width2  = 400,
    height2 = 220;

var svg2 = d3.select("#chart2")
    .append("svg")
    .attr("width", width2 + margin2.left + margin2.right)
    .attr("height", height2 + margin2.top + margin2.bottom)
    .attr("transform", "translate(" + margin2.left + "," + margin2.top + ")");

var yScale2 = d3.scale.linear()
    .range([height2 - margin2.top - margin2.bottom, 0]);

var xScale2 = d3.scale.ordinal()
    .rangeRoundBands([0, width2 - margin2.right - margin2.left], .1);

var xAxis2 = d3.svg.axis()
    .scale(xScale2)
    .orient("bottom");

d3.csv("data2.csv", function(error, data) {

  // format data to be numeric
  data = data.map(function(d){
      d.pre_2000 = +d.pre_2000;
      return d;
  });

  yScale2.domain([0, d3.max(data, function(d){ return d.pre_2000; })]);
  xScale2.domain(data.map(function(d){ return d.gender; }));

  svg2.append("g")
      .attr("transform", "translate(" + margin2.left + "," + margin2.top + ")")
      .selectAll(".bar")
      .data(data)
      .enter()
      .append("rect")
      .attr("class", function(d) { return "bar " + d.gender;} )
      .attr("x", function(d){ return xScale2(d.gender); })
      .attr("y", function(d){ return yScale2(d.pre_2000); })
      .attr("height", function(d){ return height2 - margin2.top - margin2.bottom - yScale2(d.pre_2000); })
      .attr("width", function(d){ return xScale2.rangeBand(); });

  svg2.append("g")
    .attr("transform", "translate(" + margin2.left + "," + margin2.top + ")")
    .selectAll(".text")
    .data(data)
    .enter()
    .append("text")
      .text(function(d) {return d.gender;})
      .attr("x", function(d){ return xScale2(d.gender)  + xScale2.rangeBand()/2.7; })
      .attr("y", function(d){ return yScale2(d.pre_2000) + 60; });

  //adding x axis to the bottom of chart
  svg2.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(" + margin2.left + "," + (height2 - margin2.bottom) + ")")
      .call(xAxis2);

  // annotate + title
  svg2.append("text")
    .attr("class", "title_label")
    .attr("x", 0)
    .attr("y", 0)
    .text("Women contributors were given first author position")
    .attr("class", "title_label");

  svg2.append("text")
    .attr("class", "title_label")
    .attr("x", 0)
    .attr("y", 15)
    .text("less often than men through the 20th century")
    .attr("class", "title_label");

});
