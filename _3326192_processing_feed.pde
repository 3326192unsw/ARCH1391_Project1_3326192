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

dOut = new DataOut(this, "http://www.pachube.com/api/35476.xml", "MY_API_KEY"); 

dOut.addData(0,"lightSensor");
dOut.addData(1,"Button1");
dOut.addData(2,"Button2");
dOut.addData(3,"timer");

}

void draw()
{
  mySensorValue = arduino.analogRead(0); 
  myButton1Value = arduino.analogRead(1);  
  myButton2Value = arduino.analogRead(2);
  
 //  println(myValue);
      if ((millis() - lastUpdate) > 1000){  
      println(mySensorValue);
      println(myButton1Value);
      println(myButton2Value);
      println("ready to PUT: ");
      dOut.update(0, mySensorValue);
      dOut.update(1, myButton1Value);
      dOut.update(2, myButton2Value);
      dOut.update(3, millis());
      int response = dOut.updatePachube();
      println(response);
      lastUpdate = millis();
      }
        
}

