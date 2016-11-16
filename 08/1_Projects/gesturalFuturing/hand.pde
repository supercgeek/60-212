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
    xPos = map(newXPos, -1, 1, 0, width);
    yPos = map(newYPos, 1, 0, 0, height);
    trackingConfidence = trackedState;
  }

  void updateIsClosed(boolean openOrClose) {
    if (openOrClose == true) {
      fillColor = color(240, 240, 240);
    } else { 
      fillColor = color(200, 200, 200);
    }
  }

  void render() {
    fill(fillColor);
    ellipse(xPos, yPos, 25, 25);
  }
}