void drawGrid() {
  noStroke();
  int i = 0;
  for (int y = 0; y < newGrid.totalHeight; y = y + newGrid.verticalDivisor) { //squares down
    if (i % 2 == 0) {
      fill(140, 140, 140, 80);
    } else {
      fill(240, 240, 240, 80);
    } //if even, else odd
    i++;
  }

  int j = 0;
  for (int x = 0; x < newGrid.totalWidth; x = x + newGrid.horizontalDivisor) { ////squares across
    if (j % 2 == 0) {
      fill(140, 140, 140, 80);
    } else {
      fill(240, 240, 240, 80);
    } //if even, else odd
    j++;
  }
}