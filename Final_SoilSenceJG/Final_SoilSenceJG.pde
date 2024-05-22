//FinalProject
// Jessica Gomez 
// Title: SoilSense
// Lines 88-111 reference: https://processing.org/examples/star.html
// line 166 ref: https://www.arduino.cc/reference/en/language/variables/data-types/string/functions/trim/
// images ref: https://www.freepik.com , https://www.craiyon.com/image/OBcOz_5nSTSfaajP5-0wRw

import processing.serial.*;

Serial myPort; // Serial object

PImage cactus;

PImage lotus;

int moistureLevel = 0; // Received moisture level from Arduino

int grassHeight = 80; 

float sunRotation = 0; 

// Raindrop variables
int numRaindrops = 50; // # of rain drops 
float[] raindropX = new float[numRaindrops]; //X positions of raindrops
float[] raindropY = new float[numRaindrops];// Y positions of raindrops
float[] raindropSpeed = new float[numRaindrops];// Speeds of raindrops

void setup() {
  size(1080, 720);
  
  
  String portName = Serial.list()[2]; // port
  
  // Initialize serial communication
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n'); // Receive data until newline character
  
  cactus = loadImage("cactus.png");   // Load the cactus image
  
  lotus = loadImage("lotus.png"); // Load the lotus image

  // Initialize raindrop positions and speeds
  for (int i = 0; i < numRaindrops; i++) {
    raindropX[i] = random(width);// Set random x position
    raindropY[i] = random(-height, 0);// Set random y position
    raindropSpeed[i] = random(2, 5); // Set random speed
  }
}

void draw() {
  background(137, 207, 240); // Sky background
  
  drawSun(width - 100, 100, 80, 20, 30); // Draw sun
  
  // Display received moisture level
  textAlign(CENTER, CENTER);
  textSize(24);
  fill(0);
  //text("Moisture Level: " + moistureLevel, width/2, 50);
  
  // Interpolate color based on moisture level
  color interpolatedColor;
  if (moistureLevel <= 280) {
    interpolatedColor = color(0, 0, 255); // Blue
  } else {
    // lerp color Blends two colors to find a third color between them.
    // maps moistureLevel from the range 200-445 to the range 0-1.
    interpolatedColor = lerpColor(color(0, 255, 0), color(255, 0, 0), map(moistureLevel, 200, 445, 0, 1)); 
  }
  
  // Draw grass
  fill(34, 139, 34); // Green
  rect(0, height - grassHeight - 150, width, grassHeight + 250); // Grass rectangle
  
// Draw cloud with interpolated color using ellipses
  fill(interpolatedColor);
  ellipse(100 - 30, 100, 70, 50);  // Left ellipse
  ellipse(100 + 30, 100, 70, 50);  // Right ellipse
  ellipse(100, 100 - 30, 80, 60);  // Top ellipse
  ellipse(100 - 15, 100 + 20, 60, 40); // Bottom left ellipse
  ellipse(100 + 15, 100 + 20, 60, 40); // Bottom right ellipse
  
  
  // Check if moisture level is less than 280, then add raindrops effect
  if (moistureLevel < 280) {
    drawRaindrops();
    image(lotus, width/2 - lotus.width/2, height - grassHeight - lotus.height);
      fill(0);
    textSize(25);
    text("Amidst drenched landscape, the lotus flower extrudes serene beauty ", width/2, height/2 - 250);
  }
  
  // Check if moisture level is between 280 and 400, then draw flowers along the grass
  if (moistureLevel >= 280 && moistureLevel <= 400) {
    spawnFlowers(int(map(moistureLevel, 280, 400, 1, 10))); // Map moisture level to the number of flowers to spawn
    fill(0);
    textSize(25);
    text("In the embrace of moisture, vibrant flowers burst in to bloom ", width/2, height/2 - 250);
  }
  
   if (moistureLevel >= 401 && moistureLevel <= 449) {
    image(cactus, width/2 - cactus.width/2, height - grassHeight - cactus.height);
    fill(0);
    textSize(25);
    text("In the mist of dry landscape, the resilient cactus thrives", width/2, height -50);
  }
}

void drawSun(float x, float y, float radius, float toothHeight, int toothCount) {
  pushMatrix(); //stores the current transformation state(translation, rotation, etc.) so that any changes can be undone later.
  translate(x, y); // Moves the origin to the specified (x, y) coordinates
  rotate(sunRotation); // rotates the drawing by the angle specified in sunRotation.
  noStroke();
  fill(225, 225, 0);
  beginShape(); // Starts recording shape
  float angleStep = TWO_PI / (toothCount * 2); //  calculates the angle increment between each vertex.
  for (int i = 0; i < toothCount * 2; i++) { // Loops through twice the number of teeth

    float angle = i * angleStep; // Calculate the angle for the current step
    float toothSize; // Determine the size of the tooth based on the step index
    if (i % 2 == 0) {
      toothSize = toothHeight; // If the index is even, set tooth size to the default height
    } else {
      toothSize = toothHeight * 1.5; // If the index is odd, set tooth size to 1.5 times the default height
    }
    float px = cos(angle) * (radius - toothSize);
    float py = sin(angle) * (radius - toothSize);
    vertex(px, py);
  }
  endShape(CLOSE);
  popMatrix();

  // Update rotation angle for sun 
  sunRotation += 0.2;
}

// Function to draw a drowning effect with raindrops
void drawRaindrops() {
  for (int i = 0; i < numRaindrops; i++) {   // Loop through each raindrop
    fill(0, 0, 255);
    noStroke();
    ellipse(raindropX[i], raindropY[i], 5, 10); // raindropX[i] and raindropY[i] store the x and y coordinates of the ith raindrop
    // Update the y-coordinate of the raindrop to make it fall 
    raindropY[i] += raindropSpeed[i];
    if (raindropY[i] > height) { //Check if the raindrop has fallen below the bottom of the screen
      // If the raindrop is below the screen, reset its y-coordinate to a random position above screen
      raindropY[i] = random(-100, 0);
      raindropX[i] = random(width); // Reset the x-coordinate to a random position across the width of the screen
    }
  }
}

void spawnFlowers(int numFlowers) {
  for (int i = 0; i < numFlowers; i++) { // Spawn the specified number of flowers
    int flowerX = int(random(width)); // Random x position
    int flowerY = int(random(height/2, height)); // Random y position (within bottom half of screen)
    
    // Generate random colors for the flower petals
    int red = int(random(256)); // Random red value (0-255)
    int green = int(random(256)); // Random green value (0-255)
    int blue = int(random(256)); // Random blue value (0-255)
    int[] flowerColor = {red, green, blue}; // Random color for flower petals
    
    drawFlower(flowerX, flowerY, flowerColor);
    delay(500); // Adjust the delay time (in milliseconds)
  }
}


// Function to draw a flower at a given position
void drawFlower(int x, int y, int[] flowerColor) {
  // Draw stem
  fill(0, 255, 0); // Green color for stem
  rect(x - 5, y + 50, 10, 100); // Stem 

  // Draws petals with the pre-generated color
  fill(flowerColor[0], flowerColor[1], flowerColor[2]); // Set fill color to the pre-generated color
  ellipse(x, y + 20, 60, 60);
  ellipse(x - 30, y + 20, 60, 60);
  ellipse(x + 30, y + 20, 60, 60);
  ellipse(x, y - 10, 60, 60);
  ellipse(x, y + 50, 60, 60);

  // Draws center
  fill(255, 215, 0); // Yellow 
  ellipse(x, y + 20, 20, 20);
}

// Function to receive moisture level from Arduino
void serialEvent(Serial myPort) {
  String data = myPort.readStringUntil('\n');// method reads the incoming serial data 
  if (data != null) {//The condition checks if the received data is not null. If data is available, the following code executes.
    data = data.trim(); // trim() method is used to remove any whitespace characters from the string for it to convert in to int. 
    moistureLevel = int(data); // The int(data) conversion converts the trimmed string data to an integer and assigns it to the moistureLevel variable.
  }
}
