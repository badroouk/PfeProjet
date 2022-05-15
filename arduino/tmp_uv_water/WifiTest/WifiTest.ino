#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>

#define FIREBASE_HOST "arduino-aa57e-default-rtdb.europe-west1.firebasedatabase.app"
#define FIREBASE_AUTH "4OVbEKczifavDNokfCNFiZSDZBRgZ2EfzgiNq8b2"
#define WIFI_SSID "S20+"
#define WIFI_PASSWORD "seeyouulann"


String sensor_data, values;

void setup() {
  Serial.begin(9600);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD); 
 Serial.print("connecting"); 
 while (WiFi.status() != WL_CONNECTED) { 
   Serial.print("."); 
   delay(500); 
 } 
 Serial.println(); 
 Serial.print("connected: "); 
 Serial.println(WiFi.localIP()); 
 Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
 delay(1000);

}

void loop() {

  bool Sr = false;

  while (Serial.available()) {

    //get sensor data from serial put in sensor_data
    sensor_data = Serial.readString();
    Sr = true;

  }delay(1000);

  if (Sr == true) {

    values = sensor_data;

    //get comma indexes from values variable
    int firstCommaIndex = values.indexOf(',');
    int secondCommaIndex = values.indexOf(',', firstCommaIndex + 1);
    int thirdCommaIndex = values.indexOf(',', secondCommaIndex + 1);
    int fourthCommaIndex = values.indexOf(',', thirdCommaIndex + 1);
    int fifthCommaIndex = values.indexOf(',', fourthCommaIndex + 1);
    int sixthCommaIndex = values.indexOf(',', fifthCommaIndex + 1);

    //Seperate sensor values from arduino serial port
    String temperature = values.substring(0, firstCommaIndex);
    String humidity = values.substring(firstCommaIndex + 1, secondCommaIndex);
    String ultraViolet = values.substring(secondCommaIndex + 1 , thirdCommaIndex);
    String Precipitation = values.substring(thirdCommaIndex + 1 , fourthCommaIndex);
    String luminosity = values.substring(fourthCommaIndex + 1, fifthCommaIndex);
    String CO = values.substring(fifthCommaIndex + 1, sixthCommaIndex);


    //Data storage
    Firebase.pushString("temperature", temperature);
    delay(10);
    Firebase.pushString("humidity", humidity);
    delay(10);
    Firebase.pushString("Ultraviolet",ultraViolet);
    delay(10);
    Firebase.pushString("Precipitation",Precipitation);
    delay(10);
    Firebase.pushString("Luminosity",luminosity);
    delay(10);
    Firebase.pushString("Carbon Monoxide",CO);
    delay(10);

    delay(1000);

    if (Firebase.failed()) {
      return;
    }

  }



}
