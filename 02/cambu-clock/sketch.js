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
   H = 4;
   text("Hour: " + H, 10, 22);
   text("Minute: " + M, 10, 42);
   text("Second: " + S, 10, 62);
   text("Millis: " + mils, 10, 82);

   //Call The Rectangle Creation Method
   stroke(0, 0, 100)
   line(0,125,width,125)
   line(0,210,width,210)

   console.log(H)
   var squareArray = [];

   //Create a Square For Each Month
   for (var i = 1; i < H + 1; i++) {
      console.log("i: " + i);
      //new object
      var presentSquare = new createSquare(i); //Sending i into the square constructor passes the current month into createSquare()

     //store object

     squareArray.push(presentSquare);
   }


//Printing Array
for (var k = 0; k < squareArray.length; k++) {
    console.log(squareArray[k]);
    squareWidth = squareArray[k].rectWidth
    spaceBetweenSquares = 20;
    jumpByValue = squareWidth + spaceBetweenSquares;
    squareRegion = jumpByValue * squareArray.length;

    squareArray[k].startX = (width - squareRegion)/2;
    console.log(squareArray[k].startX);

    if (squareArray[k].length <= 6) {
      console.log("5");
      console.log(squareArray[k].length);

      startY = 135;

    } else {
      if (squareArray[k] <= 6){
      //Top Row
      startY = 125;
      startX = (width - squareRegion)/2;
    } else {
      //Second Row
      startY = 210;
      startX = (width - squareRegion)/2;
    }
  }

    noStroke();
    rect(startX, startY, squareArray[k].rectWidth, squareArray[k].rectHeight);
  }
  noLoop();
}

function createSquare(currentHourToCreate) {
  this.rectWidth = 65;
  this.rectHeight = 65;
  this.currentHour = currentHourToCreate;
  // this.xBegin = findXPos(this.currentHour, this.rectWidth, this.rectHeight);
  // this.yBegin = findYPos(this.currentHour, this.rectWidth, this.rectHeight);
}
