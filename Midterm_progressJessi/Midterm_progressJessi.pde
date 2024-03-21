// Jessica Gomez 
// Theme: Garden 


PImage cherryBlossom; // Variable to store the cherry blossom image
//boolean cherryBlossomVisible = false; // Variable to track if the cherry blossom image is visible

PImage lake; 

boolean ellipseClicked = false;
boolean triangleClicked = false; 
boolean rectangleClicked = false; 


float rectWidth = 100; // Initial width of the rectangle
float ellipseSize = 80; // Initial size of the ellipse
float gearRotation = 0; // Initial rotation angle for the gear

//int angle = 0;
int radius = 150;
int value = 0; // Initial Value for triangle 

void setup() {
  size(1080, 720);
  cherryBlossom = loadImage("cherry.blossom.png"); // Load the cherry blossom image
  lake = loadImage("lake.png");
}

void draw() {
  
  /*
  if (cherryBlossomVisible) {
    drawCherryBlossomScreen();
  } else {
    drawMainScreen();
  } 
  */
   if (!ellipseClicked && !triangleClicked && !rectangleClicked) {
    drawMainScreen();
  } else {
    if (ellipseClicked) {
      drawEllipseScene();
    }
    if (triangleClicked) {
      drawTriangleScene();
    }
    if (rectangleClicked) {
      drawRectangleScene();
    }
  } 
}

/* void drawCherryBlossomScreen() {
  background(225);
  image(cherryBlossom, 0, 0, width, height);
  fill(0);
  textSize(20);
  textAlign(CENTER);
  text("Click anywhere to go back to the main screen and explore other parts of the garden", width/2, 30);
}
*/ 

void drawMainScreen() {
  // Static elements
  background(82, 190, 128); // Clear canvas

  // Organic elements with transparency
  fill(120, 200, 100, 100); // Green color with transparency
  noStroke();
  pushMatrix(); // Saves the current transformation state
  float scaleAmount = map(sin(frameCount * 0.03), -1, 1, 0.8, 1.2); // moves back and forth between two sizes
  translate(540, 360);
  scale(scaleAmount);
  ellipse(0, 0, 300, 300); // Central organic form
  popMatrix(); // restores the previous transformation state *does not affect the rest of the canvas*

  // Mechanical elements
  strokeWeight(3);

  // Ellipse 
  fill(120, 300, 50);
  ellipse(360, 250, 80, 120);
  fill(195, 155, 211);
  ellipse(800, 450, 80, 120);

  // Triangle
  fill(52, 152, 219); 
  triangle(300, 550, 200, 450, 400, 450);

  // Rectangle
  fill(200, 100, 100); // Red color for the rectangle
  rect(600, 500, 100, rectWidth); // Using a variable for height
  fill(230, 126, 34);
  rect(600, 200, rectWidth, 50); // Using a variable for width

  // Connecting lines
  stroke(150, 150, 150, 100); // Slightly transparent gray color for connectors
  line(540, 360, 400, 250);
  line(540, 360, 760, 450);
  //line(540, 360, 700, 250);
  line(540, 360, 300, 550);
  line(540, 360, 600, 500);
  line(540, 360, 600, 200);

  // Dynamic elements

  // Moving ellipse
  fill(225, 234, 46); // Ellipse color
  float angle = radians(frameCount * 0.50);
  float ellipseX = map(sin(angle), -1, 1, 300, 700); // Moving horizontally clockwise
  float ellipseY = map(cos(angle), -1, 1, 100, 600); // Moving vertically clockwise
  ellipseSize = 150;
  ellipse(ellipseX, ellipseY, ellipseSize, ellipseSize);

  // Rotating gear
  pushMatrix();
  translate(550, 350);
  rotate(gearRotation);
  drawGear(0, 0, 80, 20, 30); // Draw gear at (0, 0) with radius 80, tooth height 20, and tooth count 30
  popMatrix();
  gearRotation += 0.02; // Rotates the gear gradually

  startScreen();
}

void drawGear(float x, float y, float radius, float toothHeight, int toothCount) {
  beginShape();
  for (int i = 0; i < toothCount * 2; i++) {
    float angle = map(i, 0, toothCount * 2, 0, TWO_PI); // TWO_PI is twice the circumference of a circle so we need sin/ cosine b/c they complement 
    float toothSize = (i % 2 == 0) ? toothHeight : toothHeight * 1.5;
    float px = x + cos(angle) * (radius - toothSize);
    float py = y + sin(angle) * (radius - toothSize);
    vertex(px, py);
  }
  endShape(CLOSE);
}

void drawEllipseScene(){
  background(133, 193, 233);
  image(cherryBlossom, 0, 0, width, height);
  //grass 
  fill(100,200,100);
  rect(0,height-70, width, 70);
  
  fill(0);
  textSize(20);
  textAlign(CENTER);
  text("Click anywhere to go back to the main screen and explore other parts of the garden", width/2, 30);

}

void drawTriangleScene() {
  background(133, 193, 233);
  image(lake,0,0,width, height);
  fill(0);
  textSize(20);
  textAlign(CENTER);
  text("Opps you landed at the lake!", width/2, height/2);
}

void drawRectangleScene() {
  background(0);
  fill(50);
  textSize(20);
  textAlign(CENTER);
  text(" NOT AVAILABLE", width/2,height/2);
}

void mousePressed() {
  /* if (cherryBlossomVisible) {
    cherryBlossomVisible = false;
  } else if (mouseX >= 0 && mouseX <= width && mouseY >= 0 && mouseY <= height) {
    cherryBlossomVisible = true;
  } */
  
  /*
  Logic:!ellipseCLicked checks if the mouse is not clicked
  it sets ellipseClicked to true, indicating that the ellipse was clicked.
  and sets ther conditions to false.
  
  */
    if (!ellipseClicked && mouseX > 320 && mouseX < 400 && mouseY > 190 && mouseY < 310) {  
    ellipseClicked = true;
    triangleClicked = false;
    rectangleClicked = false;
  } else if (!triangleClicked && mouseX > 200 && mouseX < 400 && mouseY > 450 && mouseY < 550) {
    ellipseClicked = false;
    triangleClicked = true;
    rectangleClicked = false;
  } else if (!rectangleClicked && mouseX > 600 && mouseX < 700 && mouseY > 200 && mouseY < 250) {
    ellipseClicked = false;
    triangleClicked = false;
    rectangleClicked = true;
  } else { //  else if none of the  conditions are met then all conditions are set to false
    ellipseClicked = false;
    triangleClicked = false;
    rectangleClicked = false;
  }
}

void startScreen() {
  fill(0); // Black
  textSize(20); // Text size
  textAlign(CENTER, TOP);
  text("You are viewing this mechanical garden from a space", width / 2, 10);
  text("Click any shape to land on a specific part of the garden", width / 2, 40);
}
