function setup() {
  createCanvas(720, 480);
}
function mouseClicked() {
  clear();
  drawLine();
}

function drawLine(a) {
  var coordinateArray_Internal = a;
  var numberOfLines = 12;
  var numberOfLines = numberOfLines - 1;
  var lineArray = [];
  
  for (var i = 1; i <= numberOfLines + 1; i++) {
    var aLine = {
      name: "Line #" + i,
      randomX1: round(random(0, width/2)),
      randomY1: round(random(0, height)),
      randomX2: round(random(width/2, width)),
      randomY2: round(random(0, height))
    }
    
    line(aLine.randomX1, aLine.randomY1, aLine.randomX2, aLine.randomY2);
    lineArray.push(aLine);
  }

  for (var k = 0; k <= numberOfLines - 1; k++) {
    for (var n = k + 1; n <= numberOfLines - 1; n++) {
      if (n == k) {
        //Do Nothing
      } else {
        
      }
      
      // if (xOfIntersection >= twoLines.x1 && xOfIntersection <= twoLines.x2) {
      //   ellipse(xOfIntersection,yOfIntersection,5);
      // }
      
        
      
    }
  }
}