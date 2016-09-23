var newDomain; // a global declaration
var newRange;
var spaceValue = 10;
var numOfCols;
var numOfRows;

function setup() {
    createCanvas(750, 750);
    background(244, 244, 244);
    newDomain = width * 0.8; // an assignment (of a global variable)
    newRange = height * 0.8;
    numOfCols = newDomain / spaceValue;
    numOfRows = newRange / spaceValue;
}

function draw() {
    //Runs the First Time
    interruptor(newDomain, newRange, spaceValue, numOfCols, numOfRows);
    // noLoop();
}

function mousePressed() {
    background(244, 244, 244);
    //Generate a new drawing whenever the user clicks
    interruptor(newDomain, newRange, spaceValue, numOfCols, numOfRows);
}

function interruptor(newDomain, newRange, spaceValue) {
  var theGrid1 = gridGen(newDomain, newRange, spaceValue);
  var theGrid2  = gridPunch(newDomain, newRange, spaceValue, theGrid1);
  gridPrint(newDomain, newRange, spaceValue, theGrid2);

function gridGen(newDomain, newRange, spaceValue) {
  var gridGenArray = [];
  var startX = (width - newDomain)/2;
  var startY = (height - newRange)/2;

  for (var y = startY; y < newRange + startY; y = y + spaceValue) {//Y = constant,
    for (var x = startX; x < newDomain + startX; x = x + spaceValue) {//itterate X
      gridGenArray.push(randomLine(x, y)); //generate random lines and put them into a storage device
      // ellipse(x,y,5,5);
    }
  }
  return gridGenArray;
}
}

function gridPunch(newDomain, newRange, spaceValue, theGrid1) {
  var objectSpot = 0;
  var theGrid2 = [];
  var startX = (width - newDomain)/2;
  var startY = (height - newRange)/2;

  for (var y = startY; y < newRange + startY; y = y + spaceValue) {//Y = constant,
    for (var x = startX; x < newDomain + startX; x = x + spaceValue) {//itterate X
      var currentLine = theGrid1[objectSpot];

      var noiseVal = noise(x * 0.009,y* 0.009, millis());
      // console.log("first: " + currentLine.status);
      // console.log(frameCount);
      if (noiseVal >= 0.3) {
        currentLine.status = 1;
      } else {
        currentLine.status = 0;
      }
      // console.log("second: " + currentLine.status);
      theGrid2.push(currentLine); //generate random lines and put them into a storage device
      objectSpot++;
    }
  }
  return theGrid2;
}

function gridPrint(newDomain, newRange, spaceValue, theGrid2) {
  var objectSpot = 0;
  var startX = (width - newDomain)/2;
  var startY = (height - newRange)/2;
  for (var y = startY; y < newRange + startY; y = y + spaceValue) {//Y = constant,
    for (var x = startX; x <= newDomain + startX; x = x + spaceValue) {//itterate X
      var currentLine = theGrid2[objectSpot];
      if (currentLine.status == 1) {
        // console.log("print");
        //print the line
        line(currentLine.x1, currentLine.y1, currentLine.x2, currentLine.y2);
      } else {
        // console.log("no print");
        //don't print anything
      }
      objectSpot++;
    }
  }
}

function randomLine(x1, y1) {
  //create an object containing all values
  var randomLineSingle  = {
    x1: x1,
    y1: y1,
    status: 1 //1 for on, 0 for off
  };

  var length = 22;
  var randomSeed = random(0.05, 0.95);
  var biasedRandom = ExponentialSmoothedStaircase (randomSeed,0, 5);
  var angle = (biasedRandom * TWO_PI) + radians(92); //angle in radians
  // console.log(angle);
  randomLineSingle.x2 = x1 + length * cos(angle);
  randomLineSingle.y2 = y1 + length * sin(angle);
  // line(randomLineSingle.x1, randomLineSingle.y1, randomLineSingle.x2, randomLineSingle.y2);
  return randomLineSingle;

}

function ExponentialSmoothedStaircase ( x,  a,  n) {
   // See http://web.mit.edu/fnl/volume/204/winston.html

  var fa = sq (map(a, 0,1, 5,30));
  var y = 0;
  for (var i=0; i<n; i++){
    y += (1.0/(n-1.0))/(1.0 + exp(fa*(((i+1.0)/n) - x)));
  }
  y = constrain(y, 0,1);
  return y;
}
