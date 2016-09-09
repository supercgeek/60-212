newLiner aLine;

void setup() {
  size(720, 480);
  aLine = new newLiner();
}

void mousePressed() {
  //clear();
  print("pressed");
  background(51);
  drawLine();
}

void drawLine() {
  print("pressed");
  int numberOfLines = 12;
  //int lineArray[];
  ArrayList lineArray;
  lineArray = new ArrayList();

  //Lines Contain X1, Y1, X2, Y2, slope, yIntercept and X & Y Intercept After Added
  for (int i = 1; i <= numberOfLines; i++) {
    aLine.slope = (aLine.Y2 - aLine.Y1) / (aLine.X2 - aLine.X1);
    aLine.yIntercept = aLine.Y1 - (aLine.slope) * aLine.X1;
    stroke(153);
    strokeWeight(1.5);
    line(aLine.X1, aLine.Y1, aLine.X2, aLine.Y2);
    //lineArray.push(aLine);
    lineArray.add(aLine);    

  }
  for (int k = 1; k <= numberOfLines; k++) {
    for (int n = k + 1; n <= numberOfLines; n++) {
        //print(lineArray[k-1].ID + " :: " + lineArray[n-1].ID);
        print(k + " " + n);
        print(lineArray.get(k - 1) + " :: " + lineArray.get(n - 1));
        //obj kLine = lineArray.get(k - 1); 
        //lineArray[k - 1].xOfIntersection = (lineArray[k - 1].yIntercept - lineArray[n - 1].yIntercept) / (lineArray[n - 1].slope - lineArray[k - 1].slope);
        //lineArray[k - 1].yOfIntersection = (lineArray[k - 1].slope) * (lineArray[k - 1].xOfIntersection) + lineArray[k - 1].yIntercept;
        // console.log("Is " + round(lineArray[k-1].xOfIntersection) + " within: " + lineArray[n-1].X1 + " & " + lineArray[n-1].X2);
        //if (round(lineArray[k - 1].xOfIntersection) >= lineArray[n - 1].X1 && round(lineArray[k - 1].xOfIntersection) <= lineArray[n - 1].X2) {
        //  fill(204, 102, 0);
        //  noStroke();
        //  ellipse(lineArray[k - 1].xOfIntersection, lineArray[k - 1].yOfIntersection, 18);
        //}
    }
  }
}

class newLiner {
  //String ID = "ID" + i;
  int X1 = round(random(0, width/2));
  int Y1 = round(random(0, height));;
  int X2 = round(random(width/2, width));
  int Y2 = round(random(0, height));
  int slope;
  int yIntercept;
  int xOfIntersection;
  int yOfIntersection;
}