
int buttonPin = 3;     //the number of the pushbutton pin

int buttonState = 0;    //variable for reading the pushbutton status

int ledPinRed =  11;   //the number of the LED pin for RED

int ledPin = 10;
int ledState = LOW;  
long previousMillis = 0;
long interval = 100;

int vibratePin1 =  12; 
int vibratePin2 =  13; 

int speakerPin =9;
int length = 15;
char notes[] = "bc";
int beats[] = {1,1};
int tempo = 300;

int sensorPin = 0;

void playTone(int tone, int duration) {
  for (long i = 0; i < duration * 1000L; i += tone * 2) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(tone);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(tone);
  }
}

void playNote(char note, int duration) {
  char names[] = { 'c', 'd', 'e', 'f', 'g', 'a', 'b', 'C' };
  int tones[] = { 1915, 1700, 1519, 1432, 1275, 1136, 1014, 956 };
  
  // play the tone corresponding to the note name
  for (int i = 0; i < 8; i++) {
    if (names[i] == note) {
      playTone(tones[i], duration);
    }
  }
}

void setup() {
  
  Serial.begin(9600);
  pinMode(buttonPin, INPUT);  //initialize the pushbutton pin as an input 
  pinMode(ledPinRed, OUTPUT);  
  pinMode(ledPin, OUTPUT); //initialize the RED LED pin as an output    
  pinMode(vibratePin1, OUTPUT); 
  pinMode(vibratePin2, OUTPUT); 
  pinMode(speakerPin, OUTPUT);
  
}

void loop(){
  
  int val = analogRead(sensorPin);
  Serial.println(val);
  delay(100);
  
  buttonState = digitalRead(buttonPin);  //read the state of the pushbutton value

  // check if the pushbutton is pressed.
  // if it is, the buttonState is HIGH
  // if it is, the servoPin is LOW
  if (buttonState == HIGH) {     
        
   digitalWrite(ledPinRed, LOW);
    digitalWrite(ledPin, LOW);
   digitalWrite(vibratePin1, LOW); //turn LED GREEN on
   digitalWrite(vibratePin2, LOW); 
   
  } 
  
  else {

   digitalWrite(ledPinRed, HIGH);  //turn LED RED on
   digitalWrite(vibratePin1, HIGH); //turn LED GREEN on
   digitalWrite(vibratePin2, HIGH); 
   
   unsigned long currentMillis = millis();
 
  if(currentMillis - previousMillis > interval) {
    // save the last time you blinked the LED 
    previousMillis = currentMillis;   

    // if the LED is off turn it on and vice-versa:
    if (ledState == LOW)
      ledState = HIGH;
    else
      ledState = LOW;

    // set the LED with the ledState of the variable:
    digitalWrite(ledPin, ledState);
  }
  
   
    for (int i = 0; i < length; i++) {
    if (notes[i] == ' ') {
      delay(beats[i] * tempo); // rest
    } else {
      playNote(notes[i], beats[i] * tempo);
    }
     
  }
  }
}
