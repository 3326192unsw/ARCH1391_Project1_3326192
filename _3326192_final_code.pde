#include <Servo.h>

// controlling servo
Servo myservo;   //create servo object to control a servo
int pos = 0;   //variable to store the servo position
int servoPin = 9;  //the number of servo pin

//PhotoResistor Pin
int lightPin = 0; //the number of the photoresistor analog pin
int lightPin2 = 1; //the number of the photoresistor analog pin
                  
//LED Pin
int ledPinGreen =  12;      //the number of the LED pin for GREEN
int ledPinRed =  11;   //the number of the LED pin for RED
int ledPinGreen2 =  7;      //the number of the second LED pin for GREEN
int ledPinRed2 =  8;   //the number of the LED second pin for RED

int buttonPin = 2;  //the number of the pushbutton pin
int buttonState = 0;    //variable for reading the pushbutton status

void setup()
{
  pinMode(buttonPin, INPUT);  //initialize the pushbutton pin as an input
  pinMode(ledPinRed, OUTPUT);   //initialize the RED LED pin as an input
  pinMode(ledPinGreen, OUTPUT); //initialize the GREEN LED pin as an input
  pinMode(ledPinRed2, OUTPUT); //initialize the second RED LED pin as an input
  pinMode(ledPinGreen2, OUTPUT); //initialize the second GREEN LED pin as an input
}

void loop()
{
  buttonState = digitalRead(buttonPin);  //read the state of the pushbutton value
  
  if (buttonState == LOW) {     
 int threshold = 600; 
 
 if(analogRead(lightPin) > threshold){
   digitalWrite(ledPinRed,HIGH);
   digitalWrite(ledPinGreen,LOW);
   digitalWrite(ledPinRed2,HIGH);
   digitalWrite(ledPinGreen2,LOW);
    myservo.attach(9);  //attaches the servo on pin 9 to the servo object
    
    //shake to servo
    for(pos = 0; pos < 90; pos += 1)  //goes from 0 degrees to 90 degrees 
  {                                  //in steps of 1 degree 
    myservo.write(pos);   //tell servo to go to position in variable 'pos' 
    delay(0.5);    //waits 0.5ms for the servo to reach the position 
  } 
  for(pos = 90; pos>=1; pos-=1)     //goes from 90 degrees to 0 degrees 
  {                                
    myservo.write(pos);  //tell servo to go to position in variable 'pos' 
    delay(0.5);   //waits 0.5ms for the servo to reach the position 
  } 
   
 }else{
   digitalWrite(ledPinRed, HIGH);
   digitalWrite(ledPinGreen, LOW);
   digitalWrite(ledPinRed2, HIGH);
   digitalWrite(ledPinGreen2, LOW);
   digitalWrite(servoPin, LOW); 
 }
  }
   else {
   digitalWrite(ledPinRed, LOW);
   digitalWrite(ledPinGreen, HIGH);
   digitalWrite(ledPinRed2, LOW);
   digitalWrite(ledPinGreen2, HIGH);
   digitalWrite(servoPin, LOW); 
}
}
