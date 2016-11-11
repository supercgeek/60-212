class flowImg {

  color c;
  float xPosition;
  float yPosition;

  flowImg() {
    c = color(20, 70, 44, 40);
    xPosition = 50;
    yPosition = 50;
  }

  void render() {
    fill(c);
    rect(xPosition, yPosition, 200, 200);
  }

  void move(float x, float y) {
    //xPosition = xPosition + deltaX;
    //yPosition = yPosition + deltaY;
    xPosition = x;
    yPosition = y;
  }
}