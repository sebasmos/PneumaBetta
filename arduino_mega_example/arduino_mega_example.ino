#include <ArduinoJson.h>
#include <ArduinoJson.hpp>

void setup() {
  Serial1.begin(9600); // Pines-> TX1: 19, RX1: 18 (MEGA)
}

void sendJSONData() {
  String json;
  StaticJsonDocument<300> doc; // Max bytes for the JSON document

  JsonObject conf  = doc.createNestedObject("conf");
  conf["ie"] = random(0,1); // Configuration variable
  // Other configuration variables can be added, see documentation
  doc["pressure"] = random(1,100); // Any signal
  // Other signals can be added, see documentation

  serializeJson(doc, json);
  Serial1.println(json);
}

void loop() {
  sendJSONData();
  delay(500); // Any FS
}
