/*

Theme: Mechanical Garden - Tree with Triangles and Rectangles  and ellips 
 Hover over the tree to see it blossom.
*/

boolean isHovered = false;

void setup() {
  size(1080, 720);
  smooth();
}

void draw() {
  background(220, 230, 240); // Clear canvas
  
  // Draw ground
  fill(150);
  rect(0, height * 0.8, width, height * 0.2);
  
  // Calculate the position of the tree to be centered
  float treeX = width / 2;
  float treeY = height * 0.8;
  
  // Draw tree trunk
  fill(139, 69, 19); // Brown color
  rect(treeX - 50, treeY - 200, 100, 200);
  
  // Draw branches
  drawBranch(treeX, treeY - 200, PI / 2, 4);
  drawBranch(treeX, treeY - 200, -PI / 2, 4);
  
  // Check if mouse is over the tree (conditional statement)
  if (mouseX > treeX - 100 && mouseX < treeX + 100 && mouseY > treeY - 200 && mouseY < treeY) {
    isHovered = true;
  } else {
    isHovered = false;
  }
  
  // Draw blossoms if hovered
  if (isHovered) {
    drawBlossoms();
  }
}

void drawBranch(float x, float y, float angle, int levels) {
  if (levels > 0) {
    float branchLength = random(50, 100);
    float endX = x + cos(angle) * branchLength;
    float endY = y - sin(angle) * branchLength; // Subtracting here to go upwards
    stroke(139, 69, 19); // Brown color
    strokeWeight(levels);
    line(x, y, endX, endY);
    drawBranch(endX, endY, angle - random(PI/10, PI/12), levels - 1);
    drawBranch(endX, endY, angle + random(PI/10, PI/12), levels - 1);
  }
}

void drawBlossoms() {
  noStroke();
  fill(255, 192, 203); // Pink color
  for (int i = 0; i < 10; i++) {
    float x = random(width * 0.4, width * 0.6);
    float y = random(height * 0.2, height * 0.8);
    ellipse(x, y, random(20, 30), random(20, 30));
  }
}

void mouseMoved() {
  // Empty function to enable rollover response
}
