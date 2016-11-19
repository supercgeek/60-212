var dataStream = [];
function keyPressed() {
  var curKey = 0;
  
  
  if (keyCode == LEFT_ARROW) {
    curKey = "LEFT ARROW";
  } else if (keyCode == RIGHT_ARROW) {
    curKey = "RIGHT ARROW";
  } else if (key == ' '){
    curKey = "                       SPACE BAR";
                              }
  
  if (curKey != 0) {
    println(curKey);
    dataStream.push(curKey);
  }
}

function setup() {
   
}
 
function draw() {
   //  
     noLoop();
}  