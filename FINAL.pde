import processing.serial.*;
import cc.arduino.*;

import eeml.*;

Arduino arduino;
float mySensorValue;
float myButton1Value;
float myButton2Value;

float lastUpdate;

DataOut dOut;

void setup()
{
println(Arduino.list());
arduino = new Arduino(this, Arduino.list()[0], 57600);

dOut = new DataOut(this, "http://www.pachube.com/api/35559.xml", "MY_API"); 

dOut.addData(0,"lightSensor");
dOut.addData(1,"Button1");
dOut.addData(2,"Button2");

}

void draw()
{
 mySensorValue = arduino.analogRead(0); 
 
   println("Light: ");
   println(mySensorValue);
   dOut.update(0, mySensorValue);
   int response = dOut.updatePachube();
   println(response);
   delay(30000);

  myButton1Value = arduino.analogRead(1);  
   println("Button1: ");
   println(myButton1Value);
   dOut.update(1, myButton1Value);
   int response1 = dOut.updatePachube();
   println(response1);
   delay(30000);
   
  myButton2Value = arduino.analogRead(2);
   println("Button2: ");
   println(myButton2Value);
   dOut.update(2, myButton2Value);
   int response2 = dOut.updatePachube();
   println(response2);
   delay(30000);
  
}



