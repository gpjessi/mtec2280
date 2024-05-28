// Jessica Gomez P 
// WIP Final Sensor and LED

// Research: I found how to find the threshold of my sensor here https://www.youtube.com/watch?v=pFQaFnqpOtQ&t=221s
// 

// Define pins for the soil moisture sensor and LEDs
const int soilMoisturePin = A0; // Analog pin for soil moisture sensor
const int redLEDPin = 5;        // Digital pin for red LED (Dry)
const int greenLEDPin = 6;      // Digital pin for green LED (Moist)
const int blueLEDPin = 9;       // Digital pin for blue LED (Wet)

// Define threshold values for different moisture levels
const int dryThreshold = 430;    
const int moistThreshold = 197;  
const int saturatedThreshold = 110; 

void setup() {
  // Set the LED pins as OUTPUT
  pinMode(redLEDPin, OUTPUT);
  pinMode(greenLEDPin, OUTPUT);
  pinMode(blueLEDPin, OUTPUT);
  
  // Initialize serial communication
  Serial.begin(9600);
}

void loop() {
  // Read the soil moisture level
  int moistureLevel = analogRead(soilMoisturePin);

  // Send moisture level over serial
  Serial.println(moistureLevel);

  // Check moisture level against thresholds
  if (moistureLevel >= dryThreshold) {
    // Soil is dry, blink the red LED
    blinkRedLED();
    // Turn off green and blue LEDs
    digitalWrite(greenLEDPin, LOW);
    digitalWrite(blueLEDPin, LOW);
  } else if (moistureLevel < dryThreshold && moistureLevel >= moistThreshold) {
    // Soil is moist, increase the brightness of the green LED
    increaseGreenBrightness(moistureLevel);
    // Turn off red and blue LEDs
    digitalWrite(redLEDPin, LOW);
    digitalWrite(blueLEDPin, LOW);
  } else if (moistureLevel < moistThreshold && moistureLevel >= saturatedThreshold) {
    // Soil is very wet, make the blue LED breathe
    breatheBlueLED();
    // Turn off red and green LEDs
    digitalWrite(redLEDPin, LOW);
    digitalWrite(greenLEDPin, LOW);
  } else {
    // Soil is saturated, make the blue LED breathe
    breatheBlueLED();
    // Turn off red and green LEDs
    digitalWrite(redLEDPin, LOW);
    digitalWrite(greenLEDPin, LOW);
  }

  // Add some delay to avoid rapid changes
  delay(1000);
}

// Function to blink the red LED
void blinkRedLED() {
  digitalWrite(redLEDPin, HIGH);
  delay(500);
  digitalWrite(redLEDPin, LOW);
  delay(500);
}

// Function to increase the brightness of the green LED based on moisture level
void increaseGreenBrightness(int moistureLevel) {
  //The map function converts the moistureLevel from the range [moistThreshold, dryThreshold] to the range [0, 255]
  int greenBrightness = map(moistureLevel, moistThreshold, dryThreshold, 0, 255);
  analogWrite(greenLEDPin, greenBrightness); // greenBrightness is calculated from mapping & determines the cycle of PWM signal sent to the LEDpin

}

// Function to make the blue LED breathe
 // Gradually increase the brightness of the blue LED
void breatheBlueLED() {
  //initializes a variable brightness to 0.brightness < 255; is the loop's continuation condition.
  for (int brightness = 0; brightness < 255; brightness++) { // brightness++, increments the value of brightness by 1 
    analogWrite(blueLEDPin, brightness); // // Set the brightness of the blue LED
    delay(5); // delay
  }

  // Gradually decrease the brightness of the blue LED
  for (int brightness = 255; brightness > 0; brightness--) {
    analogWrite(blueLEDPin, brightness); // Set the brightness of the blue LED to the current value of 'brightness'
    delay(5);
  }
}
