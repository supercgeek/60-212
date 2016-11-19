int port1 = A0;
int port2 = A1;

//int lightSensor = 5;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(port1, INPUT);
  pinMode(port2, INPUT);
}

void loop() {
  //Serial.println("PORT 1: " + analogRead(port1));
  //  Serial.println("PORT 2: " + analogRead(port2));
  Serial.print("port 1 "); Serial.print(analogRead(port1));
  Serial.println("");
  Serial.print("port 2 "); Serial.print(analogRead(port2));
  delay(100);



}
