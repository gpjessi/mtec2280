// Jessica Gomez 
// Title: Interactive Floral Display
// Directions: Click on flower to display an image & text!

PImage center;
boolean isMousePressedOnFlower = false;
boolean isImageDisplayed = false;
int imageDisplayTime = 3000; // 3 seconds in milliseconds
int imageDisplayStartTime;
int canvasResetTime;

void setup() {
  size(1080, 720);
  background(255);
  
  center = loadImage("center.jpeg");
}

void draw() {
  // Draw the branch
  drawStemAndFlower(width/2, height - 100); // Adjusts the y-coordinate to ensure the branch is visible
  
  drawGrass();
  
  // Display the image if it's currently displayed
  if (isImageDisplayed) {
    image(center, width/2 - center.width/2, height/2 - center.height/2);
  }
  
  // Display the instruction text only if the image is not displayed and canvas is not recently reset
  if (!isImageDisplayed && (millis() - canvasResetTime > 1000)) {
    fill(0); // Set text color to black
    textSize(20);
    textAlign(CENTER);
    text("Click on flower", width/2, 30);
  }
  
  // Display the warning text when the image is displayed
  if (isImageDisplayed) {
    fill(255, 0, 0); // Set text color to red
    textSize(40);
    textAlign(CENTER, CENTER);
    text("Oops! You are too close!", width/2, height/2);
  }
  
  // Check if it's time to reset the canvas
  if (isImageDisplayed && millis() - imageDisplayStartTime > imageDisplayTime) {
    background(255); // Reset the canvas
    isImageDisplayed = false;
    canvasResetTime = millis(); // Record the time when the canvas was reset
  }
}

void drawStemAndFlower(float x, float y) {
  // Set the fill color to brown for the stem
  fill(139, 69, 19);
  
  // Draw the stem
  rect(x - 10, y, 20, 100); 
  
  // color pink for the flower
  fill(255, 192, 203);

  // Draws the petals
  ellipse(x, y - 50, 60, 60);
  ellipse(x - 30, y - 50, 60, 60);
  ellipse(x + 30, y - 50, 60, 60);
  ellipse(x, y - 80, 60, 60);
  ellipse(x, y - 20, 60, 60);

  // Flower's center
  fill(255, 215, 0); // yellow
  ellipse(x, y - 50, 20, 20);
}

void drawGrass() {
  // Draw grass at the bottom of the canvas
  fill(0, 128, 0); // Set fill color to green
  rect(0, height - 50, width, 50); // size
}


void mousePressed() {
  // Check if the mouse is pressed on the flower
  if (dist(mouseX, mouseY, width/2, height - 100 - 50) < 30) {
    isMousePressedOnFlower = true;
    isImageDisplayed = true;
    imageDisplayStartTime = millis(); // Record the time when the image was displayed
  } else {
    isMousePressedOnFlower = false;
  }
  //println("Mouse pressed on flower:", isMousePressedOnFlower);
}
