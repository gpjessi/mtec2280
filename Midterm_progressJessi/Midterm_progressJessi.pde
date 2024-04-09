// Jessica Gomez 
// Theme: Garden 

PImage cherryBlossom; // Variable to store the cherry blossom image
PImage lake;

boolean ellipseClicked = false;
boolean triangleClicked = false;
boolean rectangleClicked = false;
boolean constructionClicked = false;
boolean randomClicked = false;

float rectWidth = 100; // Initial width of the rectangle
float ellipseSize = 80; // Initial size of the ellipse
float gearRotation = 0; // Initial rotation angle for the gear

int radius = 150;
int[][] flowers = new int[100][2]; // Array to store flower positions, with space for up to 100 flowers
int flowerCount = 0;
int grassHeight = 50;

float sunRotation = 0;

void setup() {
  size(1080, 720);
  cherryBlossom = loadImage("cherry.blossom.png"); // Load the cherry blossom image
  lake = loadImage("lake.png");
  background(137, 207, 240);

  addFlower(width / 2, height - grassHeight / 2);
}

void draw() {
  if (!ellipseClicked && !triangleClicked && !rectangleClicked && !constructionClicked && !randomClicked) {
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
    if (constructionClicked){
      drawConstructionScene();
    }
    if (randomClicked) {
      drawRandomScene(); 
    }
  }
}

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

void drawEllipseScene() {
  background(133, 193, 233);
  image(cherryBlossom, 0, 0, width, height);
  //grass 
  fill(100, 200, 100);
  rect(0, height - 70, width, 70);

  fill(0);
  textSize(35);
  textAlign(CENTER);
  text("You landed at the only cherry blossom tree of the garden", width / 2, 30);
  text("Press 'U' key to return to the main scene", width / 2, height - 30);
}

void drawTriangleScene() {
  background(133, 193, 233);
  image(lake, 0, 0, width, height);
  fill(255,255,255);
  textSize(45);
  textAlign(CENTER);
  text("Opps you landed at the lake!", width / 2, height / 2);
  text("Press 'U' key to return to the main scene", width / 2, height - 30);
}

void drawRectangleScene() {
  background(137, 207, 240);

  drawSun(width - 100, 100, 80, 20, 30);

  fill(0, 255, 0);
  rect(0, height - grassHeight, width, grassHeight);

  for (int i = 0; i < flowerCount; i++) {
    drawFlower(flowers[i][0], flowers[i][1]);
  }

  fill(0);
  textSize(35);
  textAlign(CENTER);
  text("Press 'b' key to make the flowers bloom press 'r' key to reset", width / 2, 30);
   text("Press 'U' key to return to the main scene", width / 2, height - 30);

  sunRotation += 0.04;
}

void drawSun(float x, float y, float radius, float toothHeight, int toothCount) {
  pushMatrix(); // Stores transformation state
  translate(x, y);
  rotate(sunRotation); // Rotates subsequent drawing commands by the angle specified on Sun rotation vari
  fill(225, 225, 0);
  beginShape();
  for (int i = 0; i < toothCount * 2; i++) { // Iterates tooth count *2 times
  float angle = map(i, 0, toothCount * 2, 0, TWO_PI); // TWO_PI is twice the circumference of a circle so we need sin/ cosine b/c they complement
  float toothSize = (i % 2 == 0) ? toothHeight : toothHeight * 1.5; // tooth size is ajusted with index within each iteration
  float px = cos(angle) * (radius - toothSize);
  float py = sin(angle) * (radius - toothSize);
  vertex(px, py);
}
  endShape(CLOSE);
  popMatrix();

// Update rotation angle for sun
 sunRotation += 0.2;
}

// Function to draw a flower at a given position
 void drawFlower(int x, int y) {
// Draw stem
 fill(0, 255, 0); // Green color for stem
 rect(x - 5, y + 50, 10, 100); // Stem

// Draws petals
 fill(128, 0, 128); // Purple
 ellipse(x, y + 20, 60, 60);
 ellipse(x - 30, y + 20, 60, 60);
 ellipse(x + 30, y + 20, 60, 60);
 ellipse(x, y - 10, 60, 60);
 ellipse(x, y + 50, 60, 60);

// Draws center
 fill(255, 215, 0); // Yellow
 ellipse(x, y + 20, 20, 20);
}

// Function to add a new flower at the given position
 void addFlower(int x, int y) {
// Conditional - Check if the flower position is within the grass area
 if (y >= height - grassHeight) {
// Check if the array is not full
 if (flowerCount < flowers.length) {
// Add flower to the array
 flowers[flowerCount][0] = x;
 flowers[flowerCount][1] = y - 100; // Adjusts the y-coordinate to place the flower above the grass
 flowerCount++; // Increments flower count
  }
 }
}

 void keyPressed() {
 if (key == 'b') {
 addFlower((int)random(width), (int)random(height - grassHeight, height));
 } else if (key == 'r') {
   flowerCount = 0;
 } else if (key == 'u') {
   ellipseClicked = false;
   triangleClicked = false;
   rectangleClicked = false;
   constructionClicked = false;
   randomClicked = false;
 }
}

void mousePressed() {

/*
Logic:!ellipseCLicked checks if the mouse is not clicked
it sets ellipseClicked to true, indicating that the ellipse was clicked.
and sets the other functions to false

*/
if (!ellipseClicked && dist(mouseX, mouseY, 360, 250) < 40 && !triangleClicked && !rectangleClicked && !constructionClicked && !randomClicked) {
    ellipseClicked = true;
  } else if (!triangleClicked && mouseX > 200 && mouseX < 400 && mouseY > 450 && mouseY < 550 && !ellipseClicked && !rectangleClicked && !constructionClicked && !randomClicked) {
    triangleClicked = true;
  } else if (!rectangleClicked && mouseX > 600 && mouseX < 700 && mouseY > 200 && mouseY < 250 && !ellipseClicked && !triangleClicked && !constructionClicked && !randomClicked) {
    rectangleClicked = true;
  } else if (!constructionClicked && dist(mouseX, mouseY, 800, 450) < 40 && !ellipseClicked && !triangleClicked && !rectangleClicked && !randomClicked) {
    constructionClicked = true;
  } else if (!randomClicked && mouseX > 600 && mouseX < 700 && mouseY > 500 && mouseY < 600 && !ellipseClicked && !triangleClicked && !rectangleClicked && !constructionClicked) {
    randomClicked = true;
 }
} 
void startScreen() {
fill(0); // Black
textSize(35); // Text size
textAlign(CENTER, TOP);
text("You are viewing this mechanical garden from space", width / 2, 10);
text("Click any shape to land on a specific part of the garden", width / 2, 60);
}

void drawConstructionScene() {
 background(255, 0, 0); // Red background
  
  fill(255); // White text color
  textSize(48); // Big font size
  textAlign(CENTER, CENTER);
  text("Mechanical Room", width / 2, height / 2 - 40); 
  text("Authorized Personnel Only", width / 2, height / 2 + 40); 
  
  fill(255);
  textSize(25);
  textAlign(CENTER);
  text("Press 'U' key to return to the main scene", width / 2, height - 30);

}

void drawRandomScene() {
  background(200, 0, 0);
  fill(map(mouseX, 600, 700, 0, 255), map(mouseY, 500, 500 + rectWidth, 0, 255), 100); // Change color based on mouse position,map Re-maps a number from one range to another.
  rect(600, 500, 100, rectWidth);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Move mouse to any direction of scene and see the square and text color change", width / 2, height / 2);
  
  fill(255);
  textSize(25);
  textAlign(CENTER);
  text("Press 'U' key to return to the main scene", width / 2, height - 30);
}
