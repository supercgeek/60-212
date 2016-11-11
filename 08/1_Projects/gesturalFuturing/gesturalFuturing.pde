//include statements for the library
import oscP5.*;
import netP5.*;

float handLeftXPos = 0;
float handLeftYPos = 0;
float handRightXPos = 0;
float handRightYPos= 0;

float leftX; 
float leftY; 
float rightX; 
float rightY;
String curTracked;
String tracked = "Tracked";
String grabVar = "Open";
String leftOrRight = null;
boolean isLeftOpen = false;
boolean isRightOpen = false;
flowImg mainImage;

//name the oscP5 object
OscP5 oscP5;

//name the addresses you'll send and receive @
NetAddress serverAddress; //THIS

//server and client ports
int listeningPort;

//now set the addresses, etc
void setup()
{
  mainImage = new flowImg();

  background(250, 255, 255, 50);
  //if listening and sending are the same then messages will be sent back to this sketch
  listeningPort = 12345;

  oscP5 = new OscP5(this, listeningPort);
  size(1200, 700);
}

void oscEvent(OscMessage receivedMessage) {
  String[] message = receivedMessage.addrPattern().split("/");

  //ripping out all joint:hand data
  boolean isHand = message[4].equals("HandLeft") || message[4].equals("HandRight");
  if (message[3].equals("joints") && isHand == true) {

    if (message[4].equals("HandLeft")) {
      handLeftXPos = receivedMessage.get(0).floatValue();
      handLeftYPos = receivedMessage.get(1).floatValue();
      tracked = receivedMessage.get(3).stringValue();
    }
    if (message[4].equals("HandRight")) {
      handRightXPos = receivedMessage.get(0).floatValue();
      handRightYPos = receivedMessage.get(1).floatValue();
      tracked = receivedMessage.get(3).stringValue();
    }

    leftX = handLeftXPos;
    leftY = handLeftYPos;
    rightX = handRightXPos;
    rightY = handRightYPos;
    curTracked = tracked;
    //println(curTracked);
    //println(handLeftXPos, handLeftYPos, handRightXPos, handRightYPos);
  }
  if (message[3].equals("hands")) {
    leftOrRight = message[4];
    grabVar = (receivedMessage.get(0).stringValue() + "/" + leftOrRight);
    //println(grabVar);
  }
}

void draw() {
  //background(250, 255, 255, 100);
  fill(255, 255, 255, 100);
  noStroke();
  rect(0, 0, width, height);

  stroke(0);
  mainImage.render();

  //println(tracked);
  if (tracked.equals("Tracked")) {
    //println("Lft: "+ leftX + " " + leftY + "  Rft: " + rightX + " " + rightY);
    //println("Lft: "+ leftX + " " + "  Rft: " + rightY);

    //left hand 
    handCOl(grabVar);
    leftX = map(leftX, -1, 1, 0, width);
    leftY = map(leftY, 1, 0, 0, height);

    ///right hand 
    handCOl(grabVar);
    rightX = map(rightX, -1, 1, 0, width);
    rightY = map(rightY, 1, 0, 0, height);

    ////println("Lft: "+ leftX + " " + "  Rft: " + rightY);

    ////rect(50, 100, 50, 200);
    //rect(leftX, height/2-250/2, 250, 250);//width/2, height/2, leftX, leftY);
    ellipse(leftX, leftY, 25, 25);
    ellipse(rightX, rightY, 25, 25);

    //text(handLeftXPos, 50, 50, 50);
    //text(width/2, height/2, leftX, rightY);
  }
}
void handCOl(String grabVar) {
  //println(grabVar);
  //String[] colChange = grabVar.split("/");
  //println("obj: " + colChange);
  //println("colchange: "+ colChange[0] + colChange[1]);

  if (grabVar.contains("Left")) {//change something about left
    if (grabVar.contains("Open")) {
      fill(255, 5, 230);
    } else {
      fill (0, 0, 0);
      println("left closed");
      mainImage.move(leftX, leftY);
    }
  }
  if (grabVar.contains("Right")) {//change something about right
    if ( grabVar.contains("Open")) {
      fill(255, 5, 230);
    } else {
      fill (0, 0, 0);
      println("right closed");
      mainImage.move(rightX, rightY);
    }
  }
}