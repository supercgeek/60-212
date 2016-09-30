// Constants
var Y_AXIS = 1;
var X_AXIS = 2;
var c1, c2;
var prevSec;
var millisRolloverTime;

function setup() {
    colorMode(HSB, 100);
    createCanvas(750, 400);
    millisRolloverTime = 0;
    // Define colors
    c1 = color(51,31,255); //72 alpha
    c2 = color(0,0,0); //50 alpha
}

function draw() {
    background(0, 0, 05);
    //some code from http://cmuems.com/2016/60212/deliverables/deliverables-02/

    var H = hour();
    var M = minute();
    var S = second();
    H = 10;
    console.log("Number of Hours: " + H)

    if (prevSec != S) {
        millisRolloverTime = millis();
    }
    prevSec = S;
    var mils = floor(millis() - millisRolloverTime);

    // fill(0, 0, 95);
    // text("Hour: " + H, 10, 22);
    // text("Minute: " + M, 10, 42);
    // text("Second: " + S, 10, 62);
    // text("Millis: " + mils, 10, 82);

    //Call The Rectangle Creation Method
    // stroke(0, 0, 100)
    // line(0, 125, width, 125)
    // line(0, 210, width, 210)
    noStroke();

    var squareArray = [];

    //Create a Square & Push To Array
    for (var i = 0; i < H; i++) {
        var presentSquare = new createSquare(i); //Sending i into the square constructor passes the current month into createSquare()
        squareArray.push(presentSquare);
    }

    //Add Placement Location to All Squares In Array
    squareArray = squarePlacement(squareArray);







    //Draw Squares
    for (var i = 0; i < H; i++) {
        rect(squareArray[i].startX, squareArray[i].startY, squareArray[i].rectWidth, squareArray[i].rectHeight);
        //          x   y    w    h   c2  c1   axis
        setGradient(squareArray[i].startX, squareArray[i].startY, squareArray[i].rectWidth, squareArray[i].rectHeight, c2, c1, X_AXIS);
    }

    console.log("Things in the Array: " + squareArray.length);
    noLoop();
}

function squarePlacement(squareArray) {
    console.log("Length of Array: " + squareArray.length);
    //VALUES USED TO CALCULATE HORIZONTAL PLACEMENT
    squareWidth = squareArray[0].rectWidth; //The Width of Squares
    spaceBetweenSquares = 20; //The Amount of horizontal space between square
    jumpByValue = squareWidth + spaceBetweenSquares; //The Amount of space resultant from the sum of a square and the space following a square


    if (squareArray.length <= 6) {
        squareDomain = (jumpByValue * squareArray.length) - spaceBetweenSquares; //The region of the page that includes the squares and the space between them
        console.log("Case 1: Center Aligned + Expand Out");
        for (var k = 0; k < squareArray.length; k++) {
            squareArray[k].startX = (width - squareDomain) / 2 + (jumpByValue * k);
            squareArray[k].startY = (height - squareArray[k].rectHeight) / 2;
            // console.log(jumpByValue);
            console.log(squareArray[k].startX);
        }
    } else { // Case2: Two Rows
      squareDomain = (jumpByValue * 6) - spaceBetweenSquares;

        for (var k = 0; k < squareArray.length; k++) {
            if (k < 6) {
                console.log("Case 2.1: Top Row + Expand From Left");
                squareHeight = squareArray[0].rectWidth;
                spaceBelowSquares = 20;
                jumpDownValue = squareHeight + spaceBelowSquares;
                numberOfHours = squareArray.length;
                console.log("numberOfHoursL " + numberOfHours);

                numOfRows = Math.ceil(numberOfHours/6),
                console.log("Rows: " + numOfRows);
                squareRange = (jumpDownValue * numOfRows) - spaceBelowSquares;
                console.log("squareRange: "+ squareRange);

                // squareArray[k].startX = 130 + (jumpByValue * k);
                squareArray[k].startX = (width - squareDomain) / 2 + (jumpByValue * k);
                squareArray[k].startY = (height - squareRange) / 2 //+ (jumpDownValue * k);
            } else { //7 to 12
                console.log("Case 2.2: Second Row + Expand From Left");

                squareArray[k].startX = (width - squareDomain) / 2 + (jumpByValue * (k - 6));
                // squareArray[k].startX = 130 + (jumpByValue * (k - 6));
                squareArray[k].startY = (height - squareRange) / 2 + jumpDownValue // + (jumpDownValue * k);
            }
        }
    }
    return squareArray;
}

function createSquare(currentHourToCreate) {
    var squareDimentions = 98; // this value is here because width * height must be the same
    this.rectWidth = squareDimentions;
    this.rectHeight = squareDimentions;
    this.currentHour = currentHourToCreate;
    this.xBegin = 0;
    this.yBegin = 0; //findYPos(this.currentHour, this.rectWidth, this.rectHeight);
}

function setGradient(x, y, w, h, c1, c2, axis) {//function from https://p5js.org/examples/examples/Color_Linear_Gradient.php
  noFill();
  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (var i = y; i <= y+h; i++) {
      var inter = map(i, y, y+h, 0, 1);
      var c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }
  else if (axis == X_AXIS) {  // Left to right gradient
    for (var i = x; i <= x+w; i++) {
      var inter = map(i, x, x+w, 0, 1);
      var c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}