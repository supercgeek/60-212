var prevSec;
var millisRolloverTime;

function setup() {
   colorMode(HSB, 100);
   createCanvas(750, 400);
   millisRolloverTime = 0;
}

function draw() {
   background(0, 0, 05);
   //some code from http://cmuems.com/2016/60212/deliverables/deliverables-02/

   var H = hour();
   var M = minute();
   var S = second();

   if (prevSec != S) {millisRolloverTime = millis();}
   prevSec = S;
   var mils = floor(millis() - millisRolloverTime);

   fill(0, 0, 95);
   H = H - 6;
   text("Hour: " + H, 10, 22);
   text("Minute: " + M, 10, 42);
   text("Second: " + S, 10, 62);
   text("Millis: " + mils, 10, 82);

   //Call The Rectangle Creation Method
   rectGen(H);
   stroke(0, 0, 100)
   line(0,125,width,125)
   line(0,210,width,210)
   // line(x1,y1,x2,y2)
}

// }

// windowWidth & windowHeight are good for getting dimensions of the current window
// Use width & height for dimensions directly from canvas.

function rectGen(hours) {
  var squareArray = [];
  var squareObj = {
      xBegin: 0,
      yBegin: 0,
      rectWidth: 65,
      rectHeight: 65
   }
   var xSpace = {
      spaceToDistribute: (width - squareObj.rectWidth * hours),
      spacesBetweenSquares: (hours - 1),
      spaceVal: 20
   }
   xSpace.spaceOnEnds = xSpace.spaceToDistribute - (xSpace.spacesBetweenSquares * xSpace.spaceVal)

   var ySpace = {
      numOfRows: Math.ceil(hours/6),
      spaceVal: 20
   }
   ySpace.spaceToDistribute = height - squareObj.rectHeight * ySpace.numOfRows,
   ySpace.spacesBetweenRows = ySpace.numOfRows - 1,
   ySpace.spaceAboveAndBelow = ySpace.spaceToDistribute - (ySpace.spacesBetweenRows * ySpace.spaceVal)

   noStroke();
   //Fill The Squares With Gradients

   squaresPrinted = 0;
   rowsPrinted = 0;
   squaresToPrint = hours;

   for (var j = 0; j < ySpace.numOfRows; j++) {
      squareObj.yBegin = (ySpace.spaceAboveAndBelow)/2 + (squareObj.rectHeight) * j + xSpace.spaceVal * j;
      for (var i = 0; i < hours ; i++) {
      squareObj.xBegin = (xSpace.spaceOnEnds)/2 + (squareObj.rectHeight) * i + xSpace.spaceVal * i;
      rect(squareObj.xBegin, squareObj.yBegin, squareObj.rectWidth, squareObj.rectHeight)
      }
   }
}
