//include CapSense libraries to allow capacity sensor
#include <CapSense.h>

CapSense   cs_4_2 = CapSense(4,2);  

int ledPinRed =  11;  //set Red led pin at 11
int ledPinGreen =  8; //set Green led pin at 8

int ledPin = 10; //set red flashing pin at 10
int ledState = LOW;  //set led status to off
long previousMillis = 0; //set time for flashing pin
long interval = 100; //set an interval time

int vibratePin1 =  12; //set vibration motor 1 to pin 12
int vibratePin2 =  13; //set vibration motor 2 to pin 13

int sensorPin = 0; //set infrared sensor pin to analog pin 0

int speakerPin =9; // set speaker pin to 9
int length = 15; //set length
char notes[] = "bc"; //set note for speaker
int beats[] = {1,1}; // set beats
int tempo = 300; //set tempo

// set the duration of the sound
void playTone(int tone, int duration) {
  for (long i = 0; i < duration * 1000L; i += tone * 2) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(tone);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(tone);
  }
}

//set note and time for the sound
void playNote(char note, int duration) {
  char names[] = { 'c', 'd', 'e', 'f', 'g', 'a', 'b', 'C' };
  int tones[] = { 1915, 1700, 1519, 1432, 1275, 1136, 1014, 956 };
  
 
  for (int i = 0; i < 8; i++) {
    if (names[i] == note) {
      playTone(tones[i], duration);
    }
  }
}
void setup()                    
{
  //set up all the pins as and output
    Serial.begin(9600);
    
    pinMode(ledPin, OUTPUT);
    
    pinMode(ledPinRed, OUTPUT);  
    pinMode(ledPinGreen, OUTPUT);  
     
    pinMode(vibratePin1, OUTPUT); 
    pinMode(vibratePin2, OUTPUT); 

    pinMode(speakerPin, OUTPUT);
  
}

void loop()                    
{
  //activate the pins and sensor
  
  int val = analogRead(sensorPin);
  Serial.println(val);
  delay(100);
  
  //if the object near an infrared sensor
  if (val > 500) {
    
  digitalWrite(ledPinRed, HIGH); //red pin on
  digitalWrite(ledPinGreen, LOW); //green pin red
    
  long total =  cs_4_2.capSense(30);
 //and if the capacitive sensor is touch
  if (total > 1000) {
    //led red led flash
    unsigned long currentMillis = millis();
 
  if(currentMillis - previousMillis > interval) {

    previousMillis = currentMillis;   


    if (ledState == LOW)
      ledState = HIGH; //red led flash
    else
      ledState = LOW; //red led off

    digitalWrite(ledPin, ledState);  
    
    //sound plays
   
    for (int i = 0; i < length; i++) {
    if (notes[i] == ' ') {
      delay(beats[i] * tempo); 
    } else {
      playNote(notes[i], beats[i] * tempo);
    }
     
  }
  }
  //vibration motors activate
   digitalWrite(vibratePin1, HIGH); 
   digitalWrite(vibratePin2, HIGH);
   
  }
  //if capacitive sensor is not touch
  else { 
   digitalWrite(ledPin, LOW);    //red led off
   //vibration motors inavtivated
   digitalWrite(vibratePin1, LOW);
   digitalWrite(vibratePin2, LOW);}
  
}
//if nother near infrared sensor
else {
  // everything is set to off apart from green led is on
   digitalWrite(ledPin, LOW);
   digitalWrite(vibratePin1, LOW);
   digitalWrite(vibratePin2, LOW);
   digitalWrite(ledPinRed, LOW);
   digitalWrite(ledPinGreen, HIGH);
  
}
}
