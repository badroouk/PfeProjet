
#include <dht.h>
int uv_ain=A0;
int ad_value;
dht DHT;

#define DHT11_PIN 7

void setup(){
  pinMode(uv_ain,INPUT);
  Serial.begin(9600);
}

void loop(){
  int chk = DHT.read11(DHT11_PIN);
  Serial.print("Temperature = ");
  Serial.println(DHT.temperature);
  Serial.print("Humidity = ");
  Serial.println(DHT.humidity);
  delay(1000);
  ad_value=analogRead(uv_ain);
  Serial.println(ad_value);
  if(ad_value>20)
  {
    Serial.println("UV up the standard");
  }
  else
  {
    Serial.println("UV down the standard");
  }
  delay(1000);
  int sensor=analogRead(A1); // Incoming analog signal read and appointed sensor
   Serial.println("water :");
  Serial.println(sensor);
  delay(1000);//Wrote serial port
}
