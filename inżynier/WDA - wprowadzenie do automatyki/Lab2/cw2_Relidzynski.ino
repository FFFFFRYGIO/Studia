int ButtonPin =12;
int DiodaPin=5;

boolean Q1 = 0;
boolean M1 = 0;
boolean M2 = 0;
boolean M1p = 0;
boolean M2p = 0;
boolean I1 = 0;

void setup() {
  pinMode(ButtonPin, INPUT);
  pinMode(DiodaPin, OUTPUT);
  char *hej="Setup passed";
  Serial.begin(9600);
}

void loop() {
  I1 = digitalRead(ButtonPin);

  M1p = !I1&!M1&M2 | M1&!M2 | I1&M1;
  M2p = I1;

  M1 = M1p;
  M2 = M2p;
  
  Q1 = !M1&M2 | M1&!M2;

  digitalWrite(DiodaPin,Q1);
  delay(100);

}
