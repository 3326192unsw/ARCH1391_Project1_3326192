import processing.serial.*;
import cc.arduino.*;

import eeml.*;

Arduino arduino;
float mySensorValue;
float myButton1Value;
float myButton2Value;
float lastUpdate;
float lastValue;

//set variable to draw colour wheel
int segs = 24;
float rotAdjust = TWO_PI / segs / 2;
float radius;
float segWidth;
float interval = TWO_PI/ segs;

DataOut dOut;

void setup()
{
  
println(Arduino.list());
arduino = new Arduino(this, Arduino.list()[0], 57600);

dOut = new DataOut(this, "http://www.pachube.com/api/35479.xml", "my API KEY"); 

dOut.addData(0,"lightSensor"); //define the type of sensor being used, light sensor
dOut.addData(1,"Button1"); //define the type of sensor being used, push button
dOut.addData(2,"Button2");//define the type of sensor being used, push button
dOut.addData(3,"timer"); //define the timer graph

  size(400, 400); //set up size of the window
  background(000); //set colour of blackground to black
  smooth();// smooth the line
  ellipseMode(RADIUS);//set to ellips Mode
 
  radius = min(width, height) * 0.3; // make the diameter 30% of the sketch area

  drawShadeWheel();//draw color wheel
  drawCircle();//draw circle
  drawPoint(); // draw centre point
  drawText ();//draw text (number mark)

}
void drawShadeWheel() {
//set color
    color[] cols = { 
      color(216, 85, 7), //7
      color(216, 60, 7), //8
      color(216, 85, 7), //9 
      color(216, 115, 7),  //10
      color(216, 85, 7), //11
      color(216, 60, 7), //12
      color(216, 85, 7), //13
      color(216, 85, 7), //14
      color(216, 60, 7), //15
      color(216, 85, 7),  //16
      color(216, 85, 7), //17
      color(216,60,7), //18
      color(216, 85, 7),  //19
      color(216, 115, 7),  //20
      color(246, 183, 4), //21
      color(246, 203, 4),  //22
      color(246, 203, 4), //23
      color(246, 203, 4), //0
      color(246, 203, 4), //1
      color(246, 203, 4), //2
      color(246, 203, 4), //3
      color(246, 203, 4),  //4
      color(246, 203, 4),  //5
      color(246, 183, 4), //6
    }
  ;
    //draw color stript in order
    for (int i = 0; i < segs; i++) {
      fill(cols[i]);
      stroke(10);
      arc(width/2, height/2, radius, radius, 
          interval*i+rotAdjust, interval*(i+1)+rotAdjust);
    }
   
  }

void drawCircle() {
 stroke(100);
 noFill();
  //draw circle
 ellipse(200,200,100,100);
 ellipse(200,200,80,80);
 ellipse(200,200,60,60);
 ellipse(200,200,40,40);
 ellipse(200,200,20,20);

}

void drawPoint () {
  // draw center point
stroke(0);
strokeWeight(2);

point(200, 200); //centre point

}

void drawText (){
  //set text sixe
 textSize(10);
 //draw text
 text ("1AM",240,85);
 text ("2AM",275,100);
 text ("3AM",300,125);
 text ("4AM",315,155);
 text ("5AM",325,190);
 text ("6AM",325,220);
 text ("7AM",315,250);
 text ("8AM",300,280);
 text ("9AM",275,305);
 text ("10AM",240,325);
 text ("11AM",210,330);
 text ("12PM",175,330);
 text ("1PM",140,325);
 text ("2PM",115,310);
 text ("3PM",85,285);
 text ("4PM",65,250);
 text ("5PM",55,220);
 text ("6PM",55,190);
 text ("7PM",65,155);
 text ("8PM",80,125);
 text ("9PM",105,100);
 text ("10PM",125,85);
 text ("11PM",165,75);
 text ("12AM",200,75);
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
      
      //set value for the input for to draw line
  float value1 = mySensorValue;
  float value2 = myButton1Value;
  float value3 = myButton2Value;
 
 //set time in millisecond to draw line
  
   if ((millis() - lastValue) > 10000){  
      println(mySensorValue);
      println(myButton1Value);
      println(myButton2Value);
      );
      lastValue = millis();
      //set the value of lines
  line[] graph = { 
   line(value1,value2, value1, value1),
   line((value1+lastValue),value2, (value1+lastValue), (value1+lastValue)),
   line(value2,value1, value2, value2),
   line((value2+lastValue),value1, (value2+lastValue), (value2+lastValue)),
   line(value1,value3, value1, value1),
   line((value1+lastValue),value3, (value1+lastValue), (value1+lastValue)),
   line(value3,value1, value3, value3),
   line((value3+lastValue),value1, (value3+lastValue), (value3+lastValue)),
   line(value2,value3, value2, value2),
   line((value2+lastValue),value3, (value2+lastValue), (value2+lastValue)),
    }
  ;
 //draw line after previous line is drawn
    for (int i = 0; i < lastValue; i++) {
      fill(line[i]);
    }    
   }      
}

