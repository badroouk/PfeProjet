#include <DHT.h>
int uv_ain=A1;

int photocellPin = A2;     // the cell and 10K pulldown are connected to a0
int photocellReading;     // the analog reading from the analog resistor divider

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
  delay(250);
  float t = dht.readTemperature();
  Serial.print("Humidity: ");  
  Serial.print(h);
  Serial.print("%  Temperature: ");  
  Serial.print(t);  
  Serial.println("°C ");
  delay(1000);

  //UV Sensor
  int ad_value=analogRead(uv_ain);
  Serial.print("UV value: ");
  Serial.println(ad_value);
  delay(1000);

  //Water Sensor
  int sensor=analogRead(A0); // Incoming analog signal read and appointed sensor
   Serial.print("Precipitation :");
  Serial.println(sensor);
  delay(1000);

  //Photoresistor
  photocellReading = analogRead(photocellPin);
  Serial.print("Luminosity : ");
  Serial.print(photocellReading);     // the raw analog reading
  Serial.println(" LUX");
  delay(1000);
}
