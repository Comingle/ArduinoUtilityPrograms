/*
Graph an arbitrary number of readings to send to the processing multigraph sketch
 2014 Hacked together by A. Quitmeyer Public Domain
 
 you can send all these to a processing sketch
*/


//For Graphing in P5
char separator[] = " | ";

void setup()
{
  Serial.begin(115200);
  
}

void loop()
{
   int sensorValue = analogRead(A0);
           Serial.print("Heat"); //Label for the sensor
        Serial.print(":"); //Seperator between values
    Serial.print(sensorValue, DEC); //Actual value

Serial.print(separator);//Separate different readings

   int sensorValue2 = analogRead(A1);
   
        Serial.print("Humidity"); //Label for the sensor
        Serial.print(":"); //Seperator between values
    Serial.print(sensorValue2, DEC); //Actual value
  
   Serial.println();
}
