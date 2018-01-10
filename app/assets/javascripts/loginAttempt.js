// define margin
var margin = { top: 20, right: 10, bottom: 100, left: 40 },
    width = 550 - margin.right - margin.left,
    height = 350 - margin.top - margin.bottom;

// define SVG

var svg = d3.select(".login_count_graph_panel")
    .append("svg")
    .attr({
       "width": width + margin.right + margin.left,
        "height": height + margin.top + margin.bottom
    })
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.right + ")");

// define scale on axis

// define the x & y scale

var xScale = d3.scale.ordinal().rangeRoundBands([0, width], 0.2 , 0.2);

var yScale = d3.scale.linear().range([height, 0]);

// define axis

var xAxis = d3.svg.axis()
    .scale(xScale)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(yScale)
    .orient("left");

// Import the data

function render(data){
    data.forEach(function(d){
        d.count = +d.count;
        d.name = d.name;
        console.log(d.count);
    });

    data.sort(function(a,b){
        return b.count - a.count;
    });

    // specify the domains of x & y scales
    xScale.domain(data.map(function(d) { return d.name; }));
    yScale.domain([0, d3.max(data, function(d) { return d.count; })]);

    //draw the bars
    svg.selectAll("rect")
        .data(data)
        .enter()
        .append("rect")
        .attr("height",0)
        .transition()
        .duration(3000).delay(function(d,i) { return i * 200; })
        .attr("y", height)
        .attr({
            "x": function(d) { return xScale(d.name) },
            "y": function(d) { return yScale(d.count) },
            "width": xScale.rangeBand(),
            "height": function(d) { return height - yScale(d.count) }
        })
        .style("fill", function(d,i) { return 'rgb(52, 160, 232)'});

    // label the bars
    svg.selectAll("text")
        .data(data)
        .enter()
        .append('text')
        .text(function(d) { return d.count; })
        .attr("x", function(d){ return xScale(d.name) + xScale.rangeBand()/2; })
        .attr("y", function(d){ return yScale(d.count) + 12; })
        .style("fill", "white")
        .style("text-anchor", "middle");



    //draw the x axis
    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0,"+ height + ")")
        .call(xAxis)
        .selectAll("text")
        .attr("transform", "rotate(-60)")
        .attr("dx", "-.8em")
        .attr("dy", ".25em")
        .style("text-anchor", "end")// will pull the label text out
        .style("font-size", "12px");

    //draw the y axis
    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
        .style("font-size","12px");

}