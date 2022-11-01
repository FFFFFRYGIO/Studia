const int Q1Pin=9;
const int Q2Pin=10;

const int M1Pin=6;
const int M2Pin=7;
const int M3Pin=8;

const int I2Pin=13;
const int I3Pin=12;
const int I4Pin=2;

const int I6Pin=3;
const int I7Pin=4;
const int I8Pin=5;

boolean Q1 = 0;
boolean Q2 = 0;

boolean M1 = 0;
boolean M2 = 0;
boolean M3 = 0;

boolean M1p = 0;
boolean M2p = 0;
boolean M3p = 0;

boolean I2 = 0;
boolean I3 = 0;
boolean I4 = 0;

boolean I6 = 0;
boolean I7 = 0;
boolean I8 = 0;

void setup() {
  pinMode(I2Pin, INPUT);
  pinMode(I3Pin, INPUT);
  pinMode(I4Pin, INPUT);
  pinMode(I6Pin, INPUT);
  pinMode(I7Pin, INPUT);
  pinMode(I8Pin, INPUT);

  pinMode(Q1Pin, OUTPUT);
  pinMode(Q2Pin, OUTPUT);
  pinMode(M1Pin, OUTPUT);
  pinMode(M2Pin, OUTPUT);
  pinMode(M3Pin, OUTPUT);

  Serial.begin(9600);
}

void loop() {
    I2 = digitalRead(I2Pin);
    I3 = digitalRead(I3Pin);
    I4 = digitalRead(I4Pin);
    I6 = digitalRead(I6Pin);
    I7 = digitalRead(I7Pin);
    I8 = digitalRead(I8Pin);

    Serial.println("IN:");
    Serial.print(I2);
    Serial.print(" ");
    Serial.print(I3);
    Serial.print(" ");
    Serial.print(I4);
    Serial.print(" ");
    Serial.print(I6);
    Serial.print(" ");
    Serial.print(I7);
    Serial.print(" ");
    Serial.print(I8);
    Serial.print(" ");
    Serial.println(" ");

    M1p = !M1&!M2&M3&!I3&I4 | !M1&!M2&M3&I3&!I4 | !M1&M2&!M3&!I2&I4 | !M1&M2&!M3&I2&!I4 | !M1&M2&M3&!I2&I3 | !M1&M2&M3&I2&!I3 | M1&!M2&!M3&!I7 | M1&!M2&M3&!I8 | M1&M2&!M3&!I6 | M1&M2&M3&!I7 | !M1&!M2&!M3;
    M2p = !M1&M2&!M3&!I2&!I4 | !M1&M2&!M3&I2&!I4 | !M1&M2&!M3&I2&I4 | !M1&M2&M3&!I2&!I3 | !M1&M2&M3&!I2&I3 | !M1&M2&M3&I2&!I3 | !M1&M2&M3&I2&I3 | M1&!M2&!M3&I7 | M1&!M2&M3&I8 | M1&M2&!M3&!I6 | M1&M2&M3&!I7 | M1&M2&M3&I7 | !M1&!M2&!M3;
    M3p = !M1&!M2&M3&!I3&!I4 | !M1&!M2&M3&!I3&I4 | !M1&!M2&M3&I3&I4 | !M1&M2&!M3&!I2&I4 | !M1&M2&M3&!I2&!I3 | !M1&M2&M3&!I2&I3 | !M1&M2&M3&I2&I3 | M1&!M2&M3&!I8 | M1&!M2&M3&I8 | M1&M2&!M3&I6 | M1&M2&M3&!I7 | !M1&!M2&!M3;


    M1 = M1p;
    M2 = M2p;
    M3 = M3p;

    Q1 = M1&M2;
    Q2 = !M1&M3 | !M1&M2;

    Serial.println("OUT:");
    Serial.print(M1);
    Serial.print(" ");
    Serial.print(M2);
    Serial.print(" ");
    Serial.print(M3);
    Serial.print(" ");
    Serial.print(Q1);
    Serial.print(" ");
    Serial.print(Q2);
    Serial.println(" ");

    digitalWrite(M1Pin, M1);
    digitalWrite(M2Pin, M2);
    digitalWrite(M3Pin, M3);
    digitalWrite(Q1Pin, Q1);
    digitalWrite(Q2Pin, Q2);

    delay(100);
}