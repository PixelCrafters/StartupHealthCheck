d3.selectAll(".weareyvr-mark").each(function() {
  var element = d3.select(this);
  element.select("span").attr("class", "sr-only");
  drawMark(element.append("svg"), element.attr('data-height'), element.attr('data-text'), element.attr('data-colour'),  element.attr('data-radius'), element.attr('data-one'), element.attr('data-two'), element.attr('data-three'), element.attr('data-four'));
});

function drawMark(vis, height, text, colour, radius, one, two, three, four) {
  var colours = {
    'wr-spruce': '#10988b', 'brand-primary' : '#10988b', 'wr-primary' : '#10988b',
    'wr-red' : '#af1639', 'wr-colour-advisor' : '#af1639',
    'wr-pink' : '#ff769f', 'wr-colour-event' : '#ff769f',
    'wr-orange' : '#ffaf00', 'wr-colour-founder' : '#ffaf00',
    'wr-green' : '#00d679', 'wr-colour-startup' : '#00d679',
    'wr-blue' : '#4095c5', 'wr-colour-employee' : '#4095c5',
    'wr-purple' : '#601ebd', 'wr-colour-investor' : '#601ebd',
    'wr-brown' : '#8b572a', 'wr-colour-jobs' : '#8b572a',
  }
  height = height || 100;
  colour = colours[colour] || colour || colours['wr-spruce'];
  text = text || 'black';
  radius = radius || radius === 0 ? radius % 101 : Math.floor(Math.random()*101);
  one = one || one === 0 ? one % 101 : Math.floor(Math.random()*101);
  two = two || two === 0 ? two % 101 : Math.floor(Math.random()*101);
  three = three || three === 0 ? three % 101 : Math.floor(Math.random()*101);
  four = four || four === 0 ? four % 101 : Math.floor(Math.random()*101);

  var scale = height/500;
  var width = height * 0.95;
  var radius = ((parseInt(radius, 10)*70/100)+5)*scale;
  var stroke = (5*scale); // so stroke = 1 when height = 100px
  if (scale <= 0.3) stroke = 1; // <= 150px
  if (scale >= 0.5) stroke = (4*scale); // >= 250px
  if (scale >= 1) stroke = (3*scale); // >= 500px

  vis.attr('width', Math.ceil(width + (635-475)*scale)).attr('height', height);

  // Top left.
  var one = parseInt(one, 10);
  var topLeft = {
    radius: radius,
    x: (radius + stroke) + (one > 50 ? ((one-50)/50)*1.15*(width/2-2*radius) : 0),
    y: (radius + stroke) - (one < 50 ? ((one-50)/50)*2*(height/2-2*radius) : 0),
  };

  // Top right.
  var two = parseInt(two, 10);
  var topRight = {
    radius: radius,
    x: (width - radius - stroke) - (two > 50 ? ((two-50)/50)*1.15*(width/2-2*radius) : 0),
    y: (radius + stroke) - (two < 50 ? ((two-50)/50)*2*(height/2-2*radius) : 0),
  };

  // Bottom right.
  var three = parseInt(three, 10);
  var bottomRight = {
    radius: radius,
    x: (width - radius - stroke) + (three < 50 ? ((three-50)/50)*1.15*(width/2-2*radius) : 0),
    y: (height - radius - stroke) - (three > 50 ? ((three-50)/50)*2*(height/2-2*radius) : 0),
  };

  // Bottom left.
  var four = parseInt(four, 10);
  var bottomLeft = {
    radius: radius,
    x: (radius + stroke) - (four < 50 ? ((four-50)/50)*1.15*(width/2-2*radius) : 0),
    y: (height - radius - stroke) - (four > 50 ? ((four-50)/50)*2*(height/2-2*radius) : 0),
  };

  // Port of: http://en.wikibooks.org/wiki/Algorithm_Implementation/Geometry/Tangents_between_two_circles
  var tangent = function(c1, c2, tangentIndex) {
    var d_sq = (c1.x - c2.x) * (c1.x - c2.x) + (c1.y - c2.y) * (c1.y - c2.y);

    if (d_sq <= (c1.radius - c2.radius) * (c1.radius - c2.radius)) {
      return [ [] ];
    }

    var d = Math.sqrt(d_sq);
    var vx = (c2.x - c1.x) / d;
    var vy = (c2.y - c1.y) / d;

    var res = [];

    var i = 0;

    for (var sign1 = 1; sign1 >= -1; sign1 -= 2) {
      var c = (c1.radius - sign1 * c2.radius) / d;

      if (c * c > 1.0) {
        continue;
      }
      var h = Math.sqrt(Math.max(0.0, 1.0 - c * c));

      for (var sign2 = 1; sign2 >= -1; sign2 -= 2) {
        var nx = vx * c - sign2 * h * vy;
        var ny = vy * c + sign2 * h * vx;
      
        res[i] = {
          x1: c1.x + c1.radius * nx,
          y1: c1.y + c1.radius * ny,
          x2: c2.x + sign1 * c2.radius * nx,
          y2: c2.y + sign1 * c2.radius * ny,
        };
        i++;
      }
    }
    return res[tangentIndex];
  }

  var mark = vis.append("g").attr("transform", "translate(" + 80*scale + ",0)");

  // Lines

  // Top left to top right.
  var tangentTopLeftToTopRight = tangent(topLeft, topRight, 1);
  mark.append("line")
    .attr("x1", tangentTopLeftToTopRight.x1)
    .attr("y1", tangentTopLeftToTopRight.y1)
    .attr("x2", tangentTopLeftToTopRight.x2)
    .attr("y2", tangentTopLeftToTopRight.y2)
    .attr("stroke-width", stroke)
    .attr("stroke", colour);

  // Top right to bottom left.
  var tangentTopRightToBottomLeft = tangent(topRight, bottomLeft, 3);
  mark.append("line")
    .attr("x1", tangentTopRightToBottomLeft.x1)
    .attr("y1", tangentTopRightToBottomLeft.y1)
    .attr("x2", tangentTopRightToBottomLeft.x2)
    .attr("y2", tangentTopRightToBottomLeft.y2)
    .attr("stroke-width", stroke)
    .attr("stroke", colour);

  // Bottom left to bottom right.
  var tangentBottomLeftToBottomRight = tangent(bottomLeft, bottomRight, 0);
  mark.append("line")
    .attr("x1", tangentBottomLeftToBottomRight.x1)
    .attr("y1", tangentBottomLeftToBottomRight.y1)
    .attr("x2", tangentBottomLeftToBottomRight.x2)
    .attr("y2", tangentBottomLeftToBottomRight.y2)
    .attr("stroke-width", stroke)
    .attr("stroke", colour);

  // Bottom right to top left.
  var tangentBottomRightToTopLeft = tangent(bottomRight, topLeft, 2);
  mark.append("line")
    .attr("x1", tangentBottomRightToTopLeft.x1)
    .attr("y1", tangentBottomRightToTopLeft.y1)
    .attr("x2", tangentBottomRightToTopLeft.x2)
    .attr("y2", tangentBottomRightToTopLeft.y2)
    .attr("stroke-width", stroke)
    .attr("stroke", colour);

  // Arcs

  // Top left.
  var arc = d3.svg.arc()
    .innerRadius(topLeft.radius - stroke/2)
    .outerRadius(topLeft.radius - stroke/2 + stroke)
    .startAngle(Math.PI + Math.atan((topLeft.x - tangentBottomRightToTopLeft.x2) / (tangentBottomRightToTopLeft.y2 - topLeft.y)))
    .endAngle(2 * Math.PI + Math.atan((topLeft.x - tangentTopLeftToTopRight.x1) / (tangentTopLeftToTopRight.y1 - topLeft.y)));

  mark.append("path")
    .attr("d", arc)
    .style("fill", colour)
    .attr("transform", "translate(" + topLeft.x + ',' + topLeft.y + ")")

  // Top right.
  var arc = d3.svg.arc()
    .innerRadius(topRight.radius - stroke/2)
    .outerRadius(topRight.radius - stroke/2 + stroke)
    .startAngle(Math.atan((topRight.x - tangentTopLeftToTopRight.x2) / (tangentTopLeftToTopRight.y2 - topRight.y)))
    .endAngle(Math.PI + Math.atan((topRight.x - tangentTopRightToBottomLeft.x1) / (tangentTopRightToBottomLeft.y1 - topRight.y)));

  mark.append("path")
    .attr("d", arc)
    .style("fill", colour)
    .attr("transform", "translate(" + topRight.x + ',' + topRight.y + ")");

  // Bottom right.
  var arc = d3.svg.arc()
    .innerRadius(bottomRight.radius - stroke/2)
    .outerRadius(bottomRight.radius - stroke/2 + stroke)
    .startAngle(Math.atan((bottomRight.x - tangentBottomRightToTopLeft.x1) / (tangentBottomRightToTopLeft.y1 - bottomRight.y)))
    .endAngle(Math.PI + Math.atan((bottomRight.x - tangentBottomLeftToBottomRight.x2) / (tangentBottomLeftToBottomRight.y2 - bottomRight.y)));

  mark.append("path")
    .attr("d", arc)
    .style("fill", colour)
    .attr("transform", "translate(" + bottomRight.x + ',' + bottomRight.y + ")");

  // Bottom left.
  var arc = d3.svg.arc()
    .innerRadius(bottomLeft.radius - stroke/2)
    .outerRadius(bottomLeft.radius - stroke/2 + stroke)
    .startAngle(Math.PI + Math.atan((bottomLeft.x - tangentBottomLeftToBottomRight.x1) / (tangentBottomLeftToBottomRight.y1 - bottomLeft.y)))
    .endAngle(2 * Math.PI + Math.atan((bottomLeft.x - tangentTopRightToBottomLeft.x2) / (tangentTopRightToBottomLeft.y2 - bottomLeft.y)));

  mark.append("path")
    .attr("d", arc)
    .style("fill", colour)
    .attr("transform", "translate(" + bottomLeft.x + ',' + bottomLeft.y + ")");

  if (text !== 'none') {
    var letterforms = [
      { d: "M65.01 0.264l20.835 75.032L106.944 0h11.34L91.252 92.307H80.043L59.076 16.879 38.242 92.307H26.901L0 0h12l20.703 75.823 20.835-75.56H65.01z" },
      { d: "M119.997 60.263c0-22.022 10.681-33.758 30.593-33.758 18.988 0 27.428 13.187 27.428 30.989 0 1.978-0.132 3.956-0.264 6.065h-46.548c0.791 15.561 7.384 21.23 19.384 21.23 9.23 0 14.9-2.373 18.856-11.208l8.439 4.352c-5.143 11.208-14.901 15.955-27.56 15.955C131.073 93.889 119.997 83.472 119.997 60.263zM131.337 54.856h35.472c-0.528-13.846-6.593-19.384-16.747-19.384C138.985 35.472 132.523 40.879 131.337 54.856z" },
      { d: "M251.333 73.45h-42.329l-6.33 18.856h-12L222.982 0h14.769l32.307 92.307h-12.396L251.333 73.45zM212.301 63.56h35.604l-17.934-52.878L212.301 63.56z" },
      { d: "M283.771 28.088h9.758l1.187 13.582c4.483-10.549 13.582-15.428 24.527-14.637v10.813c-15.824-1.583-23.736 7.121-24.132 23.604v30.857h-11.34V28.088z" },
      { d: "M327.945 60.263c0-22.022 10.681-33.758 30.593-33.758 18.989 0 27.429 13.187 27.429 30.989 0 1.978-0.133 3.956-0.265 6.065h-46.549c0.792 15.561 7.385 21.23 19.385 21.23 9.23 0 14.901-2.373 18.856-11.208l8.439 4.352c-5.143 11.208-14.9 15.955-27.56 15.955C339.021 93.889 327.945 83.472 327.945 60.263zM339.285 54.856h35.473c-0.527-13.846-6.594-19.384-16.747-19.384C346.933 35.472 340.472 40.879 339.285 54.856z" },
      { d: "M387.546 0h12.659l26.506 45.626L453.084 0h12.264l-32.967 55.384v36.923h-11.736V55.384L387.546 0z" },
      { d: "M485.256 0l27.429 81.625L540.245 0h12l-32.308 92.307h-14.769L472.861 0H485.256z" },
      { d: "M564.77 0h36.659c20.834 0 30.988 10.022 30.988 27.692 0 14.505-6.594 23.736-18.197 27.692L634 92.307h-12.922l-18.726-34.945h-25.846v34.945H564.77V0zM576.506 10.022v37.187h24.791c12.132 0 19.384-6.198 19.384-19.121 0-11.473-6.197-18.066-19.252-18.066H576.506z" },
    ];

    var letterGroup = vis.append("g")
      .attr("class", "letters")
      .attr("transform", "translate(0," + 179*scale + ") scale(" + scale + ")");

    var letters = letterGroup.selectAll("path")
      .data(letterforms)
      .enter()
      .append("path")
      .style("fill", text);
      
    letters.attr("d", function (d) { return d.d; });
  }
}
