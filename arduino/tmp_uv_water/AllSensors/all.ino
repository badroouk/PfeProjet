#include <DHT.h>
#include <SoftwareSerial.h>
int uv_ain=A1;

int photocellPin = A2;     // the cell and 10K pulldown are connected to a2
int COPIN = A3;

#define DHTPIN 7
#define DHTTYPE DHT11

DHT dht(DHTPIN, DHTTYPE);

void setup(){
  pinMode(uv_ain,INPUT);
  Serial.begin(9600);
  dht.begin();
}

void loop(){

  //DHT11
  float h = dht.readHumidity();                                              // Reading temperature or humidity takes about 250 milliseconds!
  float t = dht.readTemperature();
//  Serial.print("Humidity: ");  
//  Serial.print(h);
//  Serial.print("%  Temperature: ");  
//  Serial.print(t);  
//  Serial.println("°C ");
//  delay(1000);

  //UV Sensor
  int uv_value=analogRead(uv_ain);
//  Serial.print("UV value: ");
//  Serial.println(uv_value);
//  delay(1000);

  //Water Sensor
  int precipitation=analogRead(A0); // Incoming analog signal read and appointed sensor
//   Serial.print("Precipitation :");
//  Serial.println(precipitation);
//  delay(1000);

  //Photoresistor
  int luminosity = analogRead(photocellPin);
//  Serial.print("Luminosity : ");
//  Serial.print(luminosity);     // the raw analog reading
//  Serial.println(" LUX");


    int CO = analogRead(COPIN);  

  String values = (String(t) + ',' + String(h) + ',' + String(uv_value) + ',' + String(precipitation) + ',' + String(luminosity) + ',' + String(CO) + ',');

  Serial.flush();
  delay(1000);

  Serial.println(values);
  delay(1000);
}
