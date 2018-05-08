#include <CapacitiveSensor.h>

/*
   CapitiveSense Library Demo Sketch
   Paul Badger 2008
   Uses a high value resistor e.g. 10M between send pin and receive pin
   Resistor effects sensitivity, experiment with values, 50K - 50M. Larger resistor values yield larger sensor values.
   Receive pin is the sensor pin - try different amounts of foil/metal on this pin
*/


CapacitiveSensor   cs_4_2 = CapacitiveSensor(4, 2);       // 10M resistor between pins 4 & 2, pin 2 is sensor pin, add a wire and or foil if desired
//CapacitiveSensor   cs_4_6 = CapacitiveSensor(4, 6);       // 10M resistor between pins 4 & 6, pin 6 is sensor pin, add a wire and or foil
//CapacitiveSensor   cs_4_8 = CapacitiveSensor(4, 8);       // 10M resistor between pins 4 & 8, pin 8 is sensor pin, add a wire and or foil
long threshold_a;
long threshold_b;
long threshold_c;
int led = 3;

void setup()
{
  cs_4_2.set_CS_AutocaL_Millis(0xFFFFFFFF);     // turn off autocalibrate on channel 1 - just as an example
  Serial.begin(9600);

  threshold_a = 20;
  threshold_b = 300 ;
  threshold_c = 30000;

  pinMode(led, OUTPUT);
}

void loop()
{
  long start = millis();
  long total1 =  cs_4_2.capacitiveSensor(30);
  //long total2 =  cs_4_6.capacitiveSensor(30);
  //long total3 =  cs_4_8.capacitiveSensor(30);

/*

  Serial.print(millis() - start);        // check on performance in milliseconds
  Serial.print("\t");                    // tab character for debug windown spacing

  Serial.println(total1);                  // print sensor output 1
  
  */
  /*
    Serial.print("\t");
    Serial.print(total2);                  // print sensor output 2
    Serial.print("\t");
    Serial.println(total3);                // print sensor output 3
  */
  if (total1 > threshold_a) {
    //digitalWrite(led, HIGH);
    if (total1 > threshold_c) {
      Serial.println("3");
    }
    else if  (total1 > threshold_b) {
      Serial.println("2");
    }
    else {

      Serial.println("1");
    }
  }
  else {
    //digitalWrite(led, LOW);
    Serial.println("0");
  }

  delay(200);                             // arbitrary delay to limit data to serial port


}
