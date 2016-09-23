var framesInLoop = 120;
var elapsedFrames;


function setup() {
   createCanvas(600, 350);
}

function draw() {

   currentFrame = frameCount % 120;
   noStroke();
   renderMyDesign(currentFrame);
}
function renderMyDesign(percent) {

   var xVal;
   var yVal = height/2;
   var sizeOfCircle = 50;
   background(20, 10, 40, 25);


   var timeToXMotion = map(currentFrame, -17, 120, -sizeOfCircle, width +sizeOfCircle);
   var warpedMotion = TukeyWindow(timeToXMotion, 150) * 600;
   var warpedMotion2 = TukeyWindow(timeToXMotion, 150) * 600;
   var shrinkFactor = TukeyWindow(currentFrame, 100);
   // console.log(timeToXMotion + " TO " + warpedMotion);

   var t = currentFrame * 10;
   fill(255, 255, 255);
   ellipse(warpedMotion, yVal, 50,50);
   fill('rgba(235, 80, 40, ' + 0.35 * currentFrame/50 +  ')');
   // fill(235, 80,40, (50*currentFrame)/5);
   ellipse(warpedMotion2 - sin(t), yVal, t * shrinkFactor, t * shrinkFactor);


}

function TukeyWindow (x, a) {//https://github.com/golanlevin/Pattern_Master
  functionName = "Tukey Window";
  // http://en.wikipedia.org/wiki/Window_function
  // The Tukey window, also known as the tapered cosine window,
  // can be regarded as a cosine lobe of width \tfrac{\alpha N}{2}
  // that is convolved with a rectangle window of width \left(1 -\tfrac{\alpha}{2}\right)N.
  // At alpha=0 it becomes rectangular, and at alpha=1 it becomes a Hann window.

  ah = a/2.0;
  omah = 1.0 - ah;

  y = 1.0;
  if (x <= ah) {
    y = 0.5 * (1.0 + cos(PI* ((2*x/a) - 1.0)));
  }
  else if (x > omah) {
    y = 0.5 * (1.0 + cos(PI* ((2*x/a) - (2/a) + 1.0)));
  }
  return y;
}
