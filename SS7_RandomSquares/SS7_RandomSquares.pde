import processing.serial.*;

Serial myPort;
int val = 0;

void setup() {
  size(400, 400);
  textAlign(CENTER);
  textSize(64);

  printArray(Serial.list());
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 115200);
}

void draw() {
  if (myPort.available() > 0) {
    val = myPort.read();
  }

  background(255);

  if (val < 100) {
    fill(random(1, 256), random(1, 256), random(1, 256));
    drawRandomRectangles(val);
  } else {
    fill(255, 0, 0);
    drawRandomRectangles(100);
  }

  fill(0);
  text(val, width/3, height/3);
}

void drawRandomRectangles(int size) {
  int numRectangles = 5; // Number of rectangles to draw
  noStroke(); 
  for (int i = 0; i < numRectangles; i++) {
    float x = random(width); // Random x-coordinate
    float y = random(height); // Random y-coordinate
    rectMode(CENTER);
    rect(x, y, size, size);
  }
}
