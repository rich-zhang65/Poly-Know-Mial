import g4p_controls.*;

// Global polynomials
Polynomial polyA = new Polynomial("0");
Polynomial polyB = new Polynomial("0");

// Program parameters
float blinksPerSecond = 45;

// Graph parameters
int xMin = -10;
int xMax = 10;
int yMin = -10;
int yMax = 10;
int xIncrement = 1;
int yIncrement = 1;

// Parameters to change max and min so the graphs do not change ratio as the graph is currently drawing
int xNextMax = xMax;
int xNextMin = xMin; 
int yNextMax = yMax;
int yNextMin = yMin;

// Graphing current values
float xAnimate = xMin;
float xPrev, yPrev;
Polynomial currentPoly;

// Polynomial A colour
int polyARed = 30;
int polyAGreen = 170;
int polyABlue = 30;

// Polynomial B colour
int polyBRed = 255;
int polyBGreen = 120;
int polyBBlue = 0;

// Set polynomial colours
color polyAStroke = color(polyARed, polyAGreen, polyABlue);
color polyBStroke = color(polyBRed, polyBGreen, polyBBlue);

void setup() {
  size(800, 800);
  frameRate(blinksPerSecond);
  createGUI();
  background(255);
  createGrid();
  polyADetails.setVisible(false); //To prevent desktop clutter and for the user to be able to call the window in if they wish
  polyBDetails.setVisible(false);
  noLoop();
}

void draw() {
  // Recreate the graph when draw is called
  if (xAnimate == xMin && currentPoly == polyA) {
    clear();
    background(255);
    createGrid();
  }
  
  strokeWeight(5);
  // If polynomial A is currently being drawn
  if (currentPoly == polyA) {
    stroke(polyAStroke);
    
    // Starting point for A
    if (xAnimate == xMin) {
      plotPoint(polyA, xAnimate); 
    }
    // Keep drawing short lines that connect between two points
    else {
      connectPoints(polyA, xAnimate);
    }
  }
  // If polynomial B is currently being drawn
  else if (currentPoly == polyB) {
    stroke(polyBStroke);
    
    // Starting point for B
    if (xAnimate == xMin) {
      plotPoint(polyB, xAnimate); 
    }
    // Keep drawing short lines that connect between two points
    else {
      connectPoints(polyB, xAnimate);
    }
  }
  
  // Increase x by small intervals to animate the graph
  xAnimate += (xMax - xMin) / 200.0;
  
  // If polynomial A reaches the end of the domain, draw polynomial B next
  if (xAnimate - (xMax - xMin) / 200.0 > xMax && currentPoly == polyA) { // Goes a little bit over the domain for when the increment doesn't reach all the way to the end
    xAnimate = xMin;
    currentPoly = polyB;
  }
  // If polynomial B reaches the end of the domain, stop the loop
  else if (xAnimate - (xMax - xMin) / 200.0 > xMax && currentPoly == polyB) { // Goes a little bit over the domain for when the increment doesn't reach all the way to the end
    noLoop();
  }
}

void createGrid() {
  // Copy the graph parameters for editing
  int modifiedXMax = xMax;
  int modifiedXMin = xMin;
  int modifiedYMax = yMax;
  int modifiedYMin = yMin;

  // Find how many extra x-values and y-values there are from each side to make the domain and range divisible by the increment values
  int extraLeftX = 0;
  int extraRightX = 0;
  int extraTopY = 0;
  int extraBottomY = 0;

  // Use modulo to edit variables and make each half of both axis divisible by the increment values
  // From right (xMax)
  while (modifiedXMax % xIncrement != 0) {
    modifiedXMax--;
    extraRightX++;
  }
  // From left (xMin)
  while (modifiedXMin % xIncrement != 0) {
    modifiedXMin++;
    extraLeftX++;
  }
  // From bottom (yMax)
  while (modifiedYMax % yIncrement != 0) {
    modifiedYMax--;
    extraBottomY++;
  }
  // From top (yMin)
  while (modifiedYMin % yIncrement != 0) {
    modifiedYMin++;
    extraTopY++;
  }

  // Find how many total extra x-values and y-values there are
  int xShrink = extraLeftX + extraRightX;
  int yShrink = extraTopY + extraBottomY;

  // Get modified domain and range
  int modifiedXRange = modifiedXMax - modifiedXMin;
  int modifiedYRange = modifiedYMax - modifiedYMin;

  // Find how much of the screen is taken up by an extra x-value and y-value
  float unitXSpace = width / (xMax - xMin);
  float unitYSpace = height / (yMax - yMin);

  // Determine how much space is needed between each gridline to evenly spread out
  float verLineSpacing = (width - xShrink * unitXSpace) / float(modifiedXRange / xIncrement);
  float horLineSpacing = (height - yShrink * unitYSpace) / float(modifiedYRange / yIncrement);

  // Find which line the x-axis and y-axis lies on
  int xAxisSpace = (0 - modifiedYMin) / yIncrement;
  int yAxisSpace = (0 - modifiedXMin) / xIncrement;

  // Find how much extra space there is from each side that the gridlines are between
  float extraLeftXSpace = extraLeftX * unitXSpace;
  float extraRightXSpace = extraRightX * unitXSpace;
  float extraTopYSpace = extraTopY * unitYSpace;
  float extraBottomYSpace = extraBottomY * unitYSpace;

  // Draw in vertical gridlines
  stroke(150);
  strokeWeight(1);
  for (int i = 0; i <= modifiedXRange / xIncrement; i++) {
    line(extraLeftXSpace + verLineSpacing * i, 0, extraLeftXSpace + verLineSpacing * i, height);
  }

  // Draw in horizontal gridlines
  for (int i = 0; i <= modifiedYRange / yIncrement; i++) {   
    line(0, extraTopYSpace + horLineSpacing * i, width, extraTopYSpace + horLineSpacing * i);
  }
  
  // Keep the axis, text, and text font at a reasonable distance from gridlines in ratio with amount of space between each line
  float ratioValue = (verLineSpacing + horLineSpacing) / 20;
  
  // Draw in the x-axis and y-axis with a thicker black line that is more noticeable than the other gridlines
  stroke(0);
  strokeWeight(ratioValue);
  line(extraLeftXSpace + verLineSpacing * yAxisSpace, 0, extraLeftXSpace + verLineSpacing * yAxisSpace, height);
  line(0, extraTopYSpace + horLineSpacing * xAxisSpace, width, extraTopYSpace + horLineSpacing * xAxisSpace);

  
  fill(0); // Make the numbers black and noticeable by contrasting with the white background
  textSize(ratioValue * 2); 

  // Write in numbers for the x-axis
  for (int i = 0; i <= modifiedXRange / xIncrement; i++) {
    // If graph is above x-axis, draw in numbers at the bottom of the screen to indicate x-values and that the x-axis is further below
    if (yMax <= 0) {
      textAlign(RIGHT, BOTTOM);
      text(modifiedXMin + i * xIncrement, extraLeftXSpace + verLineSpacing * i - ratioValue, height - ratioValue - extraBottomYSpace);
    }
    // If graph is below x-axis, draw in numbers at the top of the screen to indicate x-values and that the x-axis is further above
    else if (xAxisSpace <= 0) {
      textAlign(RIGHT, TOP);
      text(modifiedXMin + i * xIncrement, extraLeftXSpace + verLineSpacing * i - ratioValue, extraTopYSpace + ratioValue);
    }
    // Draw in numbers for x-axis from minimum value to highest value in x-increments
    else {
      textAlign(RIGHT, TOP);
      text(modifiedXMin + i * xIncrement, extraLeftXSpace + verLineSpacing * i - ratioValue, extraTopYSpace + horLineSpacing * xAxisSpace + ratioValue);
    }
  }

  for (int i = 0; i <= modifiedYRange / yIncrement; i++) {
    // If graph is further to the left of the y-axis, draw in numbers at the right of the screen to indicate y-values and that the y-axis is further to the right
    if (xMax <= 0) {
      textAlign(RIGHT, BOTTOM);
      text(modifiedYMin + i * yIncrement, width - ratioValue - extraRightXSpace, extraTopYSpace + horLineSpacing * i - ratioValue);
    }
    // If graph is further to the right of the y-axis, draw in numbers at the left of the screen to indicate y-values and that the y-axis is further to the left
    else if (yAxisSpace <= 0) {
      textAlign(LEFT, BOTTOM);
      text(modifiedYMin + i * yIncrement, extraLeftXSpace + ratioValue, extraTopYSpace + horLineSpacing * i - ratioValue);
    }
    // Draw in numbers for y-axis from minimum value to highest value in y-increments
    else {
      textAlign(RIGHT, TOP);
      text(modifiedYMin + i * yIncrement, extraLeftXSpace + verLineSpacing * yAxisSpace - ratioValue, extraTopYSpace + horLineSpacing * i + ratioValue);
    }
  }
}

void resetGraphValues() {
  // Resets values back to beginning of domain
  xAnimate = xMin;
  currentPoly = polyA;
}

void plotPoint(Polynomial p, float x) {
  // Find the corresponding y-value to the x-value
  float fOfX = p.evaluateAtX(x);
  
  // Find where the point belongs respective to the screen
  float screenX = (width / (xMax - xMin)) * (x - xMin);
  float screenY = (height / (yMax - yMin)) * (yMax - fOfX);
  
  // Draw the starting point
  point(screenX, screenY);
  
  // Store the values of the point as the previous value
  xPrev = screenX;
  yPrev = screenY;
}

void connectPoints(Polynomial p, float x) {
  // Find the corresponding y-value to the x-value
  float fOfX = p.evaluateAtX(x);
  
  // Find where the point belongs respective to the screen
  float screenX = (width / (xMax - xMin)) * (x - xMin);
  float screenY = (height / (yMax - yMin)) * (yMax - fOfX);
  
  // Connect a line from the current point to the previous point
  line(screenX, screenY, xPrev, yPrev);
  
  // Store current point as previous values
  xPrev = screenX;
  yPrev = screenY;
}
