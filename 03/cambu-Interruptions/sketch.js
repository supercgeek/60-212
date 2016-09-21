var newDomain; // a global declaration
var newRange;
var spaceValue = 15;

function setup() {
    createCanvas(750, 750);
    newDomain = width * 0.8; // an assignment (of a global variable)
    newRange = height * 0.8;
}


function draw() {
  var numOfCols = newDomain / spaceValue;
  var numOfRows = newRange / spaceValue;

    //Runs the First Time
    interruptor(newDomain, newRange, spaceValue);
    noLoop();
}

function mousePressed() {
    //Generate a new drawing whenever the user clicks
    background(255, 255, 255);
    console.log(newDomain);
    interruptor(newDomain, newRange, spaceValue);
}

function interruptor(newDomain, newRange, spaceValue) {

  var startX = (width - newDomain)/2;
  var startY = (height - newRange)/2;
  // console.log(startY);
  for (var y = startY; y < newRange + startY; y = y + spaceValue) {//Y = constant,
    for (var x = startX; x < newDomain + startX; x = x + spaceValue) {//itterate X
      randomLine(x, y);
      // ellipse(x, y, 2, 2);
      point(x, y);
    }
  }

}

function randomLine(x1, y1) {
  //calculate a length in a random direction of 50px
  var length = 15;
  var angle = random(0,360);
  var x2 = x1 + length * cos(angle);
  var y2 = y1 + length * sin(angle);
  line(x1, y1, x2, y2);
}
