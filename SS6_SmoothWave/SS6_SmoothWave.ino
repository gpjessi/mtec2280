// Jessica Gomez P 
// Concept :  A smooth wave 

const int buttonPin = 2; // Button pin
const int LED1 = 13;     // LED pins
const int LED2 = 12;
const int LED3 = 11;
const int LED4 = 10;
const int LED5 = 9;
const int LED6 = 8;

int buttonState = 0;     // Current state of the button
int previousState = 0;   // Previous state of the button

void setup() {
  // Initialize LED pins as outputs
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);
  pinMode(LED4, OUTPUT);
  pinMode(LED5, OUTPUT);
  pinMode(LED6, OUTPUT);
  
  // Initialize button pin as input
  pinMode(buttonPin, INPUT);
}

void loop() {
  // Read the state of the button
  buttonState = digitalRead(buttonPin);

  // If button is pressed and was not pressed before
  if (buttonState == HIGH && previousState == LOW) {
    // Start the wave effect
    waveEffect();
  }

  // Save the current button state for the next iteration
  previousState = buttonState;
}

// Function to create the wave effect
void waveEffect() {
  // Turn off all LEDs initially
  turnOffAllLEDs();

  // Wave effect from LED1 to LED6
  for (int i = LED1; i >= LED6; i--) {
    digitalWrite(i, HIGH);  // Turn on the current LED
    delay(100);              // Delay 
    digitalWrite(i, LOW);   // Turn off the current LED
  }

  // Wave effect from LED6 to LED1
  for (int i = LED6; i <= LED1; i++) {
    digitalWrite(i, HIGH);  // Turn on the current LED
    delay(100);              // Delay
    digitalWrite(i, LOW);   // Turn off the current LED
  }
}

// Function to turn off all LEDs
void turnOffAllLEDs() {
  digitalWrite(LED1, LOW);
  digitalWrite(LED2, LOW);
  digitalWrite(LED3, LOW);
  digitalWrite(LED4, LOW);
  digitalWrite(LED5, LOW);
  digitalWrite(LED6, LOW);
}