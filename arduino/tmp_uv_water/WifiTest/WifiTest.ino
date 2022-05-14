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

    //get sensors data from values variable by  spliting by commas and put in to variables
    String temperature = values.substring(0, firstCommaIndex);
    String humidity = values.substring(firstCommaIndex + 1, secondCommaIndex);
    String ultraViolet = values.substring(secondCommaIndex + 1 , thirdCommaIndex);
    String Precipitation = values.substring(thirdCommaIndex + 1 , fourthCommaIndex);
    String luminosity = values.substring(fourthCommaIndex + 1, fifthCommaIndex);


    //store ultrasonic sensor data as string in firebase
    Firebase.setString("temperature", temperature);
    delay(10);
    //store IR sensor 1 data as string in firebase
    Firebase.setString("humidity", humidity);
    delay(10);
    Firebase.setString("Ultraviolet",ultraViolet);
    delay(10);
    Firebase.setString("Precipitation",Precipitation);
    delay(10);
    Firebase.setString("Luminosity",luminosity);
    delay(10);
    
    //store previous sensors data as string in firebase

    delay(1000);

    if (Firebase.failed()) {
      return;
    }

  }



}
