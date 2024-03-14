//Jessica Gomez
// Theme: garden 
//title: Flowers blooming

// Array to store flower positions
int[][] flowers = new int[100][2]; // Array to store flower positions, with space for up to 100 flowers
int flowerCount = 0; // Variable that keeps track of flowers
int grassHeight = 50; // Height of the grass

float sunRotation = 0; // sun initial rotation 

void setup() {
  size(1080, 720);
  background(137, 207, 240);

  // First flower at the center of the grass
  addFlower(width / 2, height - grassHeight / 2);
}

void draw() {
  background(137, 207, 240); // Clears canvas

  drawSun(width - 100, 100, 80, 20, 30); // sun at the top right corner

  // grass
  fill(0, 255, 0); // Green
  rect(0, height - grassHeight, width, grassHeight); // Grass rectangle

  // Draw flowers
  for (int i = 0; i < flowerCount; i++) { // for loop continues as long as i is less than flountCount
    drawFlower(flowers[i][0], flowers[i][1]); // Draw each flower
  }

  // Update rotation angle for sun
  sunRotation += 0.04;

  // Display text
  fill(0); // Black text color
  textSize(20); // Text size
  textAlign(CENTER); // Center alignment
  text("Press mouse to make flowers bloom", width / 2, 30); // Text content and position
}

void drawSun(float x, float y, float radius, float toothHeight, int toothCount) {
  pushMatrix(); // Stores transformation state
  translate(x, y);
  rotate(sunRotation); // Rotates subsequent drawing commands by the angle specified on Sun rotation vari
  fill(225, 225, 0);
  beginShape();
  for (int i = 0; i < toothCount * 2; i++) { // Iterates tooth count *2 times within each iteration
    float angle = map(i, 0, toothCount * 2, 0, TWO_PI); // TWO_PI is twice the circumference of a circle so we need sin/ cosine b/c they complement 
    float toothSize = (i % 2 == 0) ? toothHeight : toothHeight * 1.5; // tooth size is ajusted with index i
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

// Function for mouse press
void mousePressed() {
  // Adds multiple flowers along the grass when mouse is pressed
  for (int i = 0; i < 5; i++) {
    addFlower((int)random(width), (int)random(height - grassHeight, height));
  }
}
