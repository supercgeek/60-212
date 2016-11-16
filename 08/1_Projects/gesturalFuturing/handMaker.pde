class hand { //class that allows the creation of any hand method

  boolean closed;
  float xPos;
  float yPos;
  color fillColor;
  String trackingConfidence; //is either Tracked, Inferred, or (maybe something else)

  hand() {
    closed = false;
    xPos = 200;
    yPos = 200;
    fillColor = color(200, 200, 200);
  }

  void updateXYC(float newXPos, float newYPos, String trackedState) { // a function to update x position, y position, and tracking confidence

    //direct map
    //xPos = map(newXPos, -1, 1, 0, width);
    //yPos = map(newYPos, 1, -1, 0, height);

    //smooothed map
    //X------
    float mappedNewXPos =  map(newXPos, -1, 1, 0, width);
    //println(mappedNewXPos);
    xPos = 0.5 * xPos + 0.5 * mappedNewXPos;
    //Y------
    float mappedNewYPos =  map(newYPos, 1, -1, 0, height);
    //println(mappedNewXPos + "," + mappedNewYPos);
    yPos = 0.5 * yPos + 0.5 * mappedNewYPos; 

    trackingConfidence = trackedState;
  }

  void updateIsClosed(boolean openOrClose) {
    if (openOrClose == true) {
      fillColor = color(230, 50, 100);
      closed = true;
    } else { // open
      fillColor = color(200, 200, 200);
      closed = false;
    }
  }

  void render() {
    fill(fillColor);
    ellipse(xPos, yPos, 25, 25);
  }
}