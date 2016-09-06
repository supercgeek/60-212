function setup() {
  createCanvas(720, 480)
}
function mouseClicked() {
  var coordinateArray_External = [];
  clear()
  var coordinateArray_External = drawLine(coordinateArray_External);
  // console.log(coordinateArray_External)
  drawIntersections(coordinateArray_External)

}

function drawLine(a) {
  var coordinateArray_Internal = a;
  var numberOfLines = 12;
  var numberOfLines = numberOfLines - 1;
  var lineArray = [];
  
  for (var i = 1; i <= numberOfLines + 1; i++) {
    var aLine = {
      name: "Line #" + i,
      randomX1: round(random(0, 720)),
      randomY1: round(random(0, 480)),
      randomX2: round(random(0, 720)),
      randomY2: round(random(0, 480))
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
        
        // From Line Two
        x3: lineArray[n].randomX1,
        x4: lineArray[n].randomX2,
        y3: lineArray[n].randomY1,
        y4: lineArray[n].randomY2
        }
      
      //INTERSETION CALCULATION
      var uA = ((twoLines.x4-twoLines.x3)*(twoLines.y1-twoLines.y3)-(twoLines.y4-twoLines.x3)*(twoLines.x1-twoLines.x3))/((twoLines.y4-twoLines.y3)*(twoLines.x2-twoLines.x1)-(twoLines.x4-twoLines.x3)*(twoLines.y2-twoLines.y1))
      var uB = ((twoLines.x2-twoLines.x1)*(twoLines.y1-twoLines.y3)-(twoLines.y2-twoLines.y1)*(twoLines.x1-twoLines.x3))/((twoLines.y4-twoLines.y3)*(twoLines.x2-twoLines.x1)-(twoLines.x4-twoLines.x3)*(twoLines.y2-twoLines.y1))
      var xOfIntersection = twoLines.x1 + uA * (twoLines.x2 - twoLines.x1)
      var yOfIntersection = twoLines.y1 + uA * (twoLines.y2 - twoLines.y1)
        
      var coordinatePair = {
          coordinateId: twoLines.pairId,
          xVal: xOfIntersection,
          yVal: yOfIntersection
        }
        
      // console.log(coordinatePair);
      coordinateArray_Internal.push(coordinatePair);
      }
    }
  }
  return coordinateArray_Internal;
}

function drawIntersections (b) {
  var coordinateArray_Internal = b;
  for (var j = 0; j <= coordinateArray_Internal.length - 1; j++) {
    var currentPairObject = coordinateArray_Internal[j];
    // console.log("Obj: " + currentPairObject.xVal)
    // console.log("j " + currentPairObject.xVal)
    var x = round(currentPairObject.xVal)
    var y = round(currentPairObject.yVal)
    console.log("(" + x + ", " + y +")")
    ellipse(x,y,5)
  }  
}