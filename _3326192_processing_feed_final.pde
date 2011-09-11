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

dOut.addData(0,"lightSensor"); //define the type of sensor being used, light sensor
dOut.addData(1,"Button1"); //define the type of sensor being used, push button
dOut.addData(2,"Button2");//define the type of sensor being used, push button
dOut.addData(3,"timer"); //define the timer graph

}

void draw()
{
  mySensorValue = arduino.analogRead(0); //set value of sensor value at A0
  myButton1Value = arduino.analogRead(1);  //set value of push button value at A2
  myButton2Value = arduino.analogRead(2);//set value of push button value at A2
  
 //  print value in millisecond 
      if ((millis() - lastUpdate) > 1000){  
      println(mySensorValue);
      println(myButton1Value);
      println(myButton2Value);
      println("ready to PUT: ");
      dOut.update(0, mySensorValue); //value of light sensor
      dOut.update(1, myButton1Value); // value of button1
      dOut.update(2, myButton2Value); //value of button2
      dOut.update(3, millis());
      int response = dOut.updatePachube();
      println(response);
      lastUpdate = millis();
      }
        
}

