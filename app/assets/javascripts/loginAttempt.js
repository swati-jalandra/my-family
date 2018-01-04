// margin and radius
var margin = { top: 20, right: 20, bottom: 20, left: 20},
    width = 400 - margin.right - margin.left,
    height = 400 - margin.top - margin.bottom,
    radius = width / 2;

var color = d3.scaleOrdinal()
    .range(["#fabaf3", "#baddfa", "#bac9fa", "#bafae5", "#f9b9cc", "#dbb2f7", "#c5bafa"]);


// arc generator
var arc = d3.arc()
    .outerRadius(radius - 10)
    .innerRadius(0);

// pie generator
var pie = d3.pie()
    .sort(null)
    .value(function(d) { return d.count });

var labelArc = d3.arc()
    .outerRadius(radius - 50)
    .innerRadius(radius - 50);

// define svg
var svg = d3.select('.login_count_graph_panel')
    .append('svg')
    .attr('width', width)
    .attr('height', height)
    .append('g')
    .attr('transform', "translate(" + width/2 + "," + height/2+ ")");

// Import the data

function render(data){
    // parse the data
    data.forEach(function(d){
        d.count = +d.count;  // returns "23" => 23
        d.name = d.name;
    });

    // append g elements (arcs)
    var g = svg.selectAll(".arc")
        .data(pie(data))
        .enter().append("g")
        .attr("class","arc");

    // append the path of arc
    g.append("path")
        .attr("d", arc)
        .style("fill", function(d) { return color(d.data.name); })
        .transition()
        .ease(d3.easeLinear)
        .duration(2000)
        .attrTween("d", pieTween);

    // append the text (labels)
    g.append("text")
        .transition()
        .ease(d3.easeLinear)
        .duration(2000)
        .attr("transform", function(d) { return "translate("+ labelArc.centroid(d) + ")";})
        .attr("dy", ".35em")
        .text(function(d) { return d.data.name; })

}

function pieTween(b){
    b.innerRadius = 0;
    var i = d3.interpolate({startAngle: 0, endAngle: 0}, b);
    return function (t) { return arc(i(t)) }
}

