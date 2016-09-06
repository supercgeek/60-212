function setup() {
  createCanvas(720, 480)
}
function mouseClicked() {
  // var coordinateArray_External = [];
  clear()
  drawLine();
  // var coordinateArray_External = drawLine(coordinateArray_External);
  // drawIntersections(coordinateArray_External)

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
    // console.log("(" + aLine.randomX1 + ", " + aLine.randomY1 + ") TO (" + aLine.randomX2 + ", " + aLine.randomY2 + ")");
    line(aLine.randomX1, aLine.randomY1, aLine.randomX2, aLine.randomY2);
    lineArray.push(aLine);
  }

  for (var k = 0; k <= numberOfLines - 1; k++) {
    for (var n = k + 1; n <= numberOfLines - 1; n++) {
      if (n == k) {
        //Do Nothing
      }
      else {
      var twoLines = {
        pairId: lineArray[k].name + " & " + lineArray[n].name,
        
        //From Line One
        x1: lineArray[k].randomX1,
        x2: lineArray[k].randomX2,
        y1: lineArray[k].randomY1,
        y2: lineArray[k].randomY2,
        slopeOfLine1: (this.y2-this.y1)/(this.x2-this.x1),
        yIntOfLine1: twoLines.y1-(slopeOfLine1)*twoLines.x1,
        yIntOfLine2: twoLines.y3-(slopeOfLine1)*twoLines.x3,
        
        // From Line Two
        x3: lineArray[n].randomX1,
        x4: lineArray[n].randomX2,
        y3: lineArray[n].randomY1,
        y4: lineArray[n].randomY2
        slopeOfLine2: (this.y3-this.y4)/(this.x3-this.x4)
        
      }
      
      //M
      // var slopeOfLine1 = (twoLines.y2-twoLines.y1)/(twoLines.x2-twoLines.x1)
      // var slopeOfLine2 = (twoLines.y3-twoLines.y4)/(twoLines.x3-twoLines.x4)
      
      //B
      var yIntOfLine1 = twoLines.y1-(slopeOfLine1)*twoLines.x1
      var yIntOfLine2 = twoLines.y3-(slopeOfLine1)*twoLines.x3
    
      //PAIRS
      var xOfIntersection = (yIntOfLine1-yIntOfLine2)/(slopeOfLine2-slopeOfLine1)
      var yOfIntersection = slopeOfLine1*xOfIntersection + yIntOfLine1;
      if (xOfIntersection >= twoLines.x1 && xOfIntersection <= twoLines.x2) {
        ellipse(xOfIntersection,yOfIntersection,5);
      }
      
      // var coordinatePair = {
      //     coordinateId: twoLines.pairId,
      //     xVal: xOfIntersection,
      //     yVal: yOfIntersection
      //   }
        
      // console.log(coordinatePair);
      // coordinateArray_Internal.push(coordinatePair);
      }
    }
  }
  // return coordinateArray_Internal;
}

// function drawIntersections (b) {
//   var coordinateArray_Internal = b;
//   for (var j = 0; j <= coordinateArray_Internal.length - 1; j++) {
//     var currentPairObject = coordinateArray_Internal[j];
//     var x = currentPairObject.xVal
//     var y = currentPairObject.yVal
//     println("(" + x + ", " + y +")")
//     ellipse(x,y,5)
//   }  
// }