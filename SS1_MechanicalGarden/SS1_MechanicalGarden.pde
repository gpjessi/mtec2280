 // Mechanical Garden a Natures Mechanic Bloom

float rectWidth = 100; // Initial width of the rectangle
float ellipseSize = 80; // Initial size of the ellipse
float gearRotation = 0; // Initial rotation angle for the gear

int angle = 0;
int radius = 150;
int value = 0; // Initial Value for riangle 

void setup() {
  size(1080, 720);
}

void draw() {
  // Static elements
  background(220, 230, 240); // Clear canvas
  
  // Organic elements with transparency
  fill(120, 200, 100, 100); // Green color with transparency
  noStroke();
  pushMatrix(); // Saves the current transformation state
  float scaleAmount = map(sin(frameCount * 0.03), -1, 1, 0.8, 1.2); // moves back and forth between two sizes
  translate(540, 360);
  scale(scaleAmount);
  ellipse(0, 0, 300, 300);// Central organic form
  popMatrix(); // restores the previus transformation state *does not affect the rest of the canva*

  // Mechanical elements
  strokeWeight(3);
  
  // Ellipse 
  fill(120, 300, 50);
  ellipse(360, 250, 80, 120);
  ellipse(800, 450, 80, 120);
  
  // Triangle
  fill( value); 
  //triangle(700, 250, 800, 250, 750, 150); // Blue color 
  triangle(300, 550, 200, 450, 400, 450);
 
  
  // Rectangle
  fill(200, 100, 100); // Red color for the rectangle
  rect(600, 500, 100, rectWidth); // Using a variable for height
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
  float angle = radians (frameCount *0.50);
  float ellipseX = map(sin(angle), -1, 1, 300, 700); // Moving horizontally clockwise
  float ellipseY = map(cos(angle), -1, 1, 100, 600); // Moving vertically clockwise
  ellipseSize = 150;
  ellipse(ellipseX, ellipseY, ellipseSize, ellipseSize);
  
  // Growing rectangle
  fill(200, 100, 100); 
  rectWidth += 0.1; // Increasing width gradually
  if (rectWidth > 200) { // Reset width if it becomes too large
    rectWidth = 150;
  }
  //rect(600, 200, rectWidth, 150); 
  
  // Shifting ellipse size
  //ellipseSize = map(sin(frameCount * 0.03), -1, 1, 60, 100); // moves back and forth between two sizes
  
  // Rotating gear
  pushMatrix();
  translate(550, 350);
  rotate(gearRotation);
  drawGear(0, 0, 80, 20, 30); // Draw gear at (0, 0) with radius 80, tooth height 20, and tooth count 30
  popMatrix();
  gearRotation += 0.02; // Rotate the gear gradually
}

void drawGear(float x, float y, float radius, float toothHeight, int toothCount) {
  beginShape();
  for (int i = 0; i < toothCount * 2; i++) {
    float angle = map(i, 0, toothCount * 2, 0, TWO_PI); // TWO_PI is twice the circumference of a circle so we need sin/ cosine b/c they compliment 
    float toothSize = (i % 2 == 0) ? toothHeight : toothHeight * 1.5;
    float px = x + cos(angle) * (radius - toothSize);
    float py = y + sin(angle) * (radius - toothSize);
    vertex(px, py);
  }
  endShape(CLOSE);
}
void mousePressed(){  // Controls the triangle if pressed 
  if (value == 0) {
    value = 225;
  }else value = 0;
}
