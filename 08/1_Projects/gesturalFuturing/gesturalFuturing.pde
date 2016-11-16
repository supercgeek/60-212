//include statements for the library
import oscP5.*;
import netP5.*;

img image1; //Constructor for Image
hand leftHand; //the object that will contain all of the leftHand Data 
hand rightHand; //the object that will contain all of the rightHand Data
OscP5 oscP5; //name the oscP5 object
NetAddress serverAddress; //name the addresses you'll send and receive @
PImage imageFill1;

int listeningPort; //server and client ports

float rectX = 200;
float rectY =  200;
float rectWidth = 350;
float rectHeight = 250;

//now set the addresses, etc
void setup()
{
  imageFill1 = loadImage("IMG_1087.JPG");
  //if listening and sending are the same then messages will be sent back to this sketch
  listeningPort = 12345;
  oscP5 = new OscP5(this, listeningPort);

  size(1200, 700);
  background(rectX, rectY, rectWidth, rectHeight);

  // create image object 

  image1 = new img(rectX, rectY, rectWidth, rectHeight);

  // create hand objects
  leftHand = new hand();
  rightHand = new hand();
}

void oscEvent(OscMessage receivedMessage) {
  String[] message = receivedMessage.addrPattern().split("/");

  //ripping out all joint:hand data
  boolean isHand = message[4].equals("HandLeft") || message[4].equals("HandRight");
  if (message[3].equals("joints") && isHand == true) {

    if (message[4].equals("HandLeft")) {
      float handLeftXPos = receivedMessage.get(0).floatValue();
      float handLeftYPos = receivedMessage.get(1).floatValue();
      String tracked = receivedMessage.get(3).stringValue();

      leftHand.updateXYC(handLeftXPos, handLeftYPos, tracked);
    }
    if (message[4].equals("HandRight")) {
      float handRightXPos = receivedMessage.get(0).floatValue();
      float handRightYPos = receivedMessage.get(1).floatValue();
      String tracked = receivedMessage.get(3).stringValue();

      rightHand.updateXYC(handRightXPos, handRightYPos, tracked);
    }
  }
  //ripping out all hand:closed data
  if (message[3].equals("hands")) {
    String leftOrRight = message[4];
    String grabVar = (receivedMessage.get(0).stringValue() + "/" + leftOrRight);

    if (grabVar.contains("Left")) {//change something about left
      if (grabVar.contains("Open")) {
        leftHand.updateIsClosed(false);
      } else {
        leftHand.updateIsClosed(true);
      }
    }
    if (grabVar.contains("Right")) {//change something about the right hand
      if (grabVar.contains("Open")) {
        rightHand.updateIsClosed(false);
      } else {
        rightHand.updateIsClosed(true);
      }
    }
  }
  //println ("rectX" + rectX);
  //println ("rectY" + rectY);
  //println ("rectWidth" + rectWidth);
  //println ("rectHeight" + rectHeight);
}
void hoverCheck() {
  //check if right hand is hovering over the object
  if (rightHand.xPos >= image1.xPosition && rightHand.xPos <= image1.xPosition + image1.rectWidth && 
    rightHand.yPos >= image1.yPosition && rightHand.yPos <= image1.yPosition + image1.rectHeight) {

    //println(rightHand.xPos  +  " >= " + rectX + " && " + rightHand.xPos + " < = " + (rectX+rectWidth));

    image1.updateHoverState(true);

    if (rightHand.closed == true) {
      println("hoverGrab");
      image1.move(rightHand.xPos, rightHand.yPos);
      toScale();
    }
  } else {
    image1.updateHoverState(false);
  }
}
void toScale() {
  if (leftHand.xPos >= image1.xPosition && leftHand.xPos <= image1.xPosition + image1.rectWidth && 
    leftHand.yPos >= image1.yPosition && leftHand.yPos <= image1.yPosition + image1.rectHeight) {
    //left hand also hovering

    if (leftHand.closed == true) {
      //get distance
      float rightToLeftDist = dist(rightHand.xPos, rightHand.yPos, leftHand.xPos,leftHand.yPos);
      println(rightToLeftDist);
      float scaleVar = map(rightToLeftDist, 0, 0.5*image1.rectWidth, 0, 1.5);
      image1.rectWidth = image1.rectWidth*scaleVar; 
      image1.rectHeight = image1.rectHeight*scaleVar;
      //scale by some multuplier 
    }
  }
}

void draw() {
  noStroke();
  fill(255, 255, 255, 100);
  rect(0, 0, width, height);
  hoverCheck();
  //image1.render();

  image(imageFill1, image1.xPosition, image1.yPosition);
  imageFill1.resize(int(image1.rectWidth), int(image1.rectHeight));
  image1.render();
  scale(1);
  leftHand.render();
  rightHand.render();
}