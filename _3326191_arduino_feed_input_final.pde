#include <Firmata.h>

int lightPin = A0; //number of light sensor pin at A0

int button1Pin = A1;     //the number of the pushbutton pin at A1
int button2Pin = A2;  //the number of the pushbutton pin at A2
int ledPinGreen = 10;      //the number of the LED pin for GREEN at 10
int ledPinRed =  9;  //the number of the LED pin for RED at 9
int ledPinBlue =  8;  //the number of the LED pin for BLUE at 8

int button1State = 0;  
int button2State = 0; 


void setup() {
    Firmata.setFirmwareVersion(0, 1);
    Firmata.begin(57600);
    
    pinMode(button1Pin, INPUT); //set button as an inout
    pinMode(button2Pin, INPUT);  //set button as an inout
      
    pinMode(ledPinGreen, OUTPUT); //set GREEN led as an inout
    pinMode(ledPinRed, OUTPUT);  //set RED led as an inout
    pinMode(ledPinBlue, OUTPUT); //set BLUE led as an inout
}
	
void loop() {
  //get value from the inputs
  int sensorValue = analogRead(0);   
  Firmata.sendAnalog(0, sensorValue);
  
  int button1Value = analogRead(1);   
  Firmata.sendAnalog(1, button1Value);
  
  int button2Value = analogRead(2);   
  Firmata.sendAnalog(2, button2Value);
 
 button1State = digitalRead(button1Pin);
 button2State = digitalRead(button2Pin);
 
   digitalWrite(ledPinGreen, HIGH); //LED GREEN off
   digitalWrite(ledPinRed, HIGH);//LED RED off
   digitalWrite(ledPinBlue, HIGH); //LED BLUE off
 
 if (button1State == HIGH) {     //if the button is pressed
   digitalWrite(ledPinGreen, LOW); //turn LED GREEN on
  
  } 
  
if (button2State == HIGH) {     //if the button is pressed
   digitalWrite(ledPinRed, LOW);//turn LED RED on
  } 
  
  
int threshold = 600; //set value for threshold
 
 if(analogRead(lightPin) > threshold){ //if the light sensor detect light morethan 600
   digitalWrite(ledPinBlue, LOW); //turn BLUE GREEN on
   
 }
} 




