function setup() {
  createCanvas(720, 480);
}

function mouseClicked() {
  clear();
  background(51);
  drawLine();
}

function drawLine() {
  var numberOfLines = 12;
  var lineArray = [];

  //Lines Contain X1, Y1, X2, Y2, slope, yIntercept and X & Y Intercept After Added
  for (var i = 1; i <= numberOfLines; i++) {
    var aLine = {
      ID: "ID: " + i,
      X1: round(random(0, width / 2)), //thanks to Marisa Lu for this idea on making sure lines always have a X2 & Y2 end values that are after their start values
      Y1: round(random(0, height)),
      X2: round(random(width / 2, width)),
      Y2: round(random(0, height))
    }
    aLine.slope = (aLine.Y2 - aLine.Y1) / (aLine.X2 - aLine.X1);
    aLine.yIntercept = aLine.Y1 - (aLine.slope) * aLine.X1;
    stroke('white');
    strokeWeight(1.5);
    line(aLine.X1, aLine.Y1, aLine.X2, aLine.Y2);
    lineArray.push(aLine);
  }
  for (var k = 1; k <= numberOfLines; k++) {
    for (var n = k + 1; n <= numberOfLines; n++) {
      if (n == k) {console.log("are you sure?")} else {
        console.log(lineArray[k-1].ID + " :: " + lineArray[n-1].ID)
        lineArray[k - 1].xOfIntersection = (lineArray[k - 1].yIntercept - lineArray[n - 1].yIntercept) / (lineArray[n - 1].slope - lineArray[k - 1].slope);
        lineArray[k - 1].yOfIntersection = (lineArray[k - 1].slope) * (lineArray[k - 1].xOfIntersection) + lineArray[k - 1].yIntercept
          // console.log("Is " + round(lineArray[k-1].xOfIntersection) + " within: " + lineArray[n-1].X1 + " & " + lineArray[n-1].X2);
        if (round(lineArray[k - 1].xOfIntersection) >= lineArray[n - 1].X1 && round(lineArray[k - 1].xOfIntersection) <= lineArray[n - 1].X2) {
          fill('rgba(100%,95%,32%,0.55)');
          noStroke();
          ellipse(lineArray[k - 1].xOfIntersection, lineArray[k - 1].yOfIntersection, 18);
        }
      }
    }
  }
  // console.log(lineArray)
}