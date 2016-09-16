newLiner lineArray[] = new newLiner[0];
int numberOfLines = 12;

void setup() {
  size(720, 480);
  for (int j = 0; j < numberOfLines; j++) {
    lineArray = (newLiner[])append(lineArray, new newLiner());//learned this from Lumar ;)
  }
}
void draw() {}
void mousePressed() {
  clear();
  for (int j = 0; j < numberOfLines; j++) {
    lineArray[j] = null;
    lineArray[j] = new newLiner();
  }
  drawLine();
}

void drawLine() {
  for (int i = 0; i < numberOfLines; i++) {
    lineArray[i].drawLine();
  }
  
  for (int k = 1; k <= numberOfLines; k++) {
    for (int n = k + 1; n <= numberOfLines; n++) {
         float xOfIntersection = (lineArray[k - 1].yIntercept - lineArray[n - 1].yIntercept) / (lineArray[n - 1].slope - lineArray[k - 1].slope);

         float yOfIntersection = (lineArray[k - 1].slope) * (xOfIntersection) + lineArray[k - 1].yIntercept;
         
         
         
         //println(k + "::" + n);
         //println("LINE 1: " +  lineArray[k-1].X1 + ", " + lineArray[k-1].Y1 + " TO " + lineArray[k-1].X2 + ", " + lineArray[k-1].Y2 + "M: " + lineArray[k-1].slope);
         
         //println("LINE 2: " +  lineArray[n-1].X1 + ", " + lineArray[n-1].Y1 + " TO " + lineArray[n-1].X2 + ", " + lineArray[n-1].Y2 + "M: " + lineArray[n-1].slope);
       
         //println(xOfIntersection + ", " + yOfIntersection);
        
       if (xOfIntersection >= lineArray[n - 1].X1 && xOfIntersection <= lineArray[n - 1].X2) {
          fill(204, 76, 0, 180);
          noStroke();
          ellipse(xOfIntersection, yOfIntersection, 18, 18);
        }
    }
  }
}
class newLiner {
  //When this is called on line 7, a new group of data is created and added to the lineArray.
  float X1 = round(random(0, width/2));
  float Y1 = round(random(0, height));
  float X2 = round(random(width/2, width));
  float Y2 = round(random(0, height));
  
  float slope = (Y2 - Y1) / (X2 - X1);
  float yIntercept = Y1 - (slope) * X1;
  
  void drawLine() {
  stroke(153);
  strokeWeight(1.5);
  line(X1, Y1, X2, Y2);
  }
}