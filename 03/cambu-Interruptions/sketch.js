var newDomain; // a global declaration
var newRange;
var spaceValue = 13;

function setup() {
    createCanvas(750, 750);
    background(244, 244, 244);
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
  background(244, 244, 244);
    //Generate a new drawing whenever the user clicks

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
    }
  }

}

function randomLine(x1, y1) {
  //calculate a length in a random direction of 50px
  var length = 20;
  var randomSeed = random(0.05, 0.95)
  var biasedRandom = ExponentialSmoothedStaircase (randomSeed,0, 5);
  var angle = (biasedRandom * TWO_PI) + radians(92); //angle in radians
  console.log(angle);
  var x2 = x1 + length * cos(angle);
  var y2 = y1 + length * sin(angle);
  line(x1, y1, x2, y2);
}

function ExponentialSmoothedStaircase ( x,  a,  n) {
   // See http://web.mit.edu/fnl/volume/204/winston.html

  var fa = sq (map(a, 0,1, 5,30));
  var y = 0;
  for (var i=0; i<n; i++){
    y += (1.0/(n-1.0))/ (1.0 + exp(fa*(((i+1.0)/n) - x)));
  }
  y = constrain(y, 0,1);
  return y;
}
