#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>
#include <WiFiClient.h>
#include <ESP8266HTTPClient.h>

#define WIFI_SSID "La_Fibre_dOrange_2.4G_AE78"
#define WIFI_PASSWORD "9AC46C401C8AC7A64040CB"
#define host "192.168.11.101"


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
 delay(1000);

}

void loop() {

    sensor_data = Serial.readString();

    delay(1000);

    values = sensor_data;

    //get comma indexes from values variable
    int firstCommaIndex = values.indexOf(',');
    int secondCommaIndex = values.indexOf(',', firstCommaIndex + 1);
    int thirdCommaIndex = values.indexOf(',', secondCommaIndex + 1);
    int fourthCommaIndex = values.indexOf(',', thirdCommaIndex + 1);
    int fifthCommaIndex = values.indexOf(',', fourthCommaIndex + 1);
    int sixthCommaIndex = values.indexOf(',', fifthCommaIndex + 1);


    //get sensors data from values variable by  spliting by commas and put in to variables
    String temperature = values.substring(0, firstCommaIndex);
    String humidity = values.substring(firstCommaIndex + 1, secondCommaIndex);
    String ultraViolet = values.substring(secondCommaIndex + 1 , thirdCommaIndex);
    String Precipitation = values.substring(thirdCommaIndex + 1 , fourthCommaIndex);
    String luminosity = values.substring(fourthCommaIndex + 1, fifthCommaIndex);
    String CO = values.substring(fifthCommaIndex + 1, sixthCommaIndex);


    //Values as integers
    int temp = temperature.toInt();
    int hum = humidity.toInt();
    int uv = ultraViolet.toInt();
    int prec = Precipitation.toInt();
    int lum = luminosity.toInt();
    int carbon = CO.toInt();
    

    //store ultrasonic sensor data as string in firebase
    WiFiClient client;
    const int httpPort = 80;
    if (!client.connect(host, httpPort)) {
        Serial.println("connection failed");
        return;
    }

    Serial.print("GET http://192.168.11.101/iot/dht.php?&temperature=");
    client.print("GET http://192.168.11.101/iot/dht.php?&temperature=");     //YOUR URL
    Serial.println(temp);
    client.print(temp);
    client.print("&humidity=");
    Serial.println("&humidity=");
    client.print(hum);
    Serial.println(hum);
    client.print("&ultraviolet=");
    Serial.println("&ultraviolet=");
    client.print(uv);
    Serial.println(uv);
    client.print("&precipitation=");
    Serial.println("&precipitation=");
    client.print(prec);
    Serial.println(prec);
    client.print("&luminosity=");
    Serial.println("&luminosity=");
    client.print(lum);
    Serial.println(lum);
    client.print("&carbonmonoxide=");
    Serial.println("&carbonmonoxide=");
    client.print(carbon);
    Serial.println(carbon);
    client.print(" ");      //SPACE BEFORE HTTP/1.1
    client.print("HTTP/1.1");
    client.println();
    client.println("Host: 192.168.11.101");
    client.println("Connection: close");
    client.println();

    unsigned long timeout = millis();
    while (client.available() == 0) {
        if (millis() - timeout > 1000) {
            Serial.println(">>> Client Timeout !");
            client.stop();
            return;
        }
    }

    // Read all the lines of the reply from server and print them to Serial
    while(client.available()) {
        String line = client.readStringUntil('\r');
        Serial.print(line);
        
    }

    Serial.println();
    Serial.println("closing connection");

    delay(1000);

  



}
