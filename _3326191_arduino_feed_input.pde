#include <Firmata.h>

int lightPin = A0;

int button1Pin = A1;     //the number of the pushbutton pin
int button2Pin = A2;  
int ledPinGreen = 10;      //the number of the LED pin for GREEN
int ledPinRed =  9;
int ledPinBlue =  8;

int button1State = 0;  
int button2State = 0; 

void setup() {
    Firmata.setFirmwareVersion(0, 1);
    Firmata.begin(57600);
    
    pinMode(button1Pin, INPUT);
    pinMode(button2Pin, INPUT);
      
    pinMode(ledPinGreen, OUTPUT);
    pinMode(ledPinRed, OUTPUT);
    pinMode(ledPinBlue, OUTPUT);
}
	
void loop() {
  int sensorValue = analogRead(0);   
  Firmata.sendAnalog(0, sensorValue);
  
  int button1Value = analogRead(1);   
  Firmata.sendAnalog(1, button1Value);
  
  int button2Value = analogRead(2);   
  Firmata.sendAnalog(2, button2Value);
 
 button1State = digitalRead(button1Pin);
 button2State = digitalRead(button2Pin);
 
   digitalWrite(ledPinGreen, HIGH); //turn LED GREEN on
   digitalWrite(ledPinRed, HIGH);
   digitalWrite(ledPinBlue, HIGH); 
 
 if (button1State == HIGH) {     
   digitalWrite(ledPinGreen, LOW); //turn LED GREEN on
  
  } 
  
if (button2State == HIGH) {     
   digitalWrite(ledPinRed, LOW);
  } 
  
  
int threshold = 600; 
 
 if(analogRead(lightPin) > threshold){
   digitalWrite(ledPinBlue, LOW);
   
 }
} 




