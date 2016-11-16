//include statements for the library
import oscP5.*;
import netP5.*;

flowImg mainImage; //Constructor for Image
hand leftHand; //the object that will contain all of the leftHand Data 
hand rightHand; //the object that will contain all of the rightHand Data
OscP5 oscP5; //name the oscP5 object
NetAddress serverAddress; //name the addresses you'll send and receive @

int listeningPort; //server and client ports

//now set the addresses, etc
void setup()
{
  //if listening and sending are the same then messages will be sent back to this sketch
  listeningPort = 12345;
  oscP5 = new OscP5(this, listeningPort);

  size(1200, 700);
  background(250, 255, 255, 50);

  // create image object 
  mainImage = new flowImg();

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
}
void draw() {
  rect(0,0,width,height);
  mainImage.render();
  rightHand.render();
  leftHand.render();
}