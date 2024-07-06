//Radosław Relidzyński WCY20IY4S1
//Winda kursuje pomiędzy kondygnacjami 1, 2 i 3
//Stan początkowy - winda ustawia się na 2 kondygnacji
//Opis stanów: 
//0 - Stan początkowy – winda ustawia się na 2 piętrze
//1 - Winda stoi na 1 piętrze
//2 - Winda stoi na 2 piętrze
//3 - Winda stoi na 3 piętrze
//4 - Winda jedzie na 2 piętro w górę
//5 - Winda jedzie na 3 piętro w górę
//6 - Winda jedzie na 1 piętro w dół
//7 - Winda jedzie na 2 piętro w dół

int Q1Pin=5;
int Q2Pin=4;
int M1Pin=6;
int M2Pin=7;
int M3Pin=8;
int I1Pin=13;
int I2Pin=12;
int I3Pin=2;
int I4Pin=3;
int I5Pin=4;
int I6Pin=5;

boolean Q1 = 0;
boolean Q2 = 0;
boolean M1 = 0;
boolean M2 = 0;
boolean M3 = 0;
boolean M1p = 0;
boolean M2p = 0;
boolean M3p = 0;
boolean I1 = 0;
boolean I2 = 0;
boolean I3 = 0;
boolean I4 = 0;
boolean I5 = 0;
boolean I6 = 0;

void setup() {
  pinMode(I1Pin, INPUT);
  pinMode(I2Pin, INPUT);
  pinMode(I3Pin, INPUT);
  pinMode(I4Pin, INPUT);
  pinMode(I5Pin, INPUT);
  pinMode(I6Pin, INPUT);

  pinMode(Q1Pin, OUTPUT);
  pinMode(Q2Pin, OUTPUT);
  pinMode(M1Pin, OUTPUT);
  pinMode(M2Pin, OUTPUT);
  pinMode(M3Pin, OUTPUT);

  Serial.begin(9600);
}

void loop() {
  I1 = digitalRead(I1Pin);
  I2 = digitalRead(I2Pin);
  I3 = digitalRead(I3Pin);
  I4 = digitalRead(I4Pin);
  I5 = digitalRead(I5Pin);
  I6 = digitalRead(I6Pin);

  M1p = !M1&!M2&M3&!I2&I3 | !M1&!M2&M3&I2&!I3 | !M1&M2&!M3&!I1&I3 | !M1&M2&!M3&I1&!I3 | !M1&M2&M3&!I1&I2 | !M1&M2&M3&I1&!I2 | M1&!M2&!M3 | M1&!M2&M3 | M1&M2&!M3 | M1&M2&M3 | !M1&!M2&!M3;
  M2p = !M1&M2&!M3&!I1&!I3 | !M1&M2&!M3&I1&!I3 | !M1&M2&!M3&I1&I3 | !M1&M2&M3&!I1&!I2 | !M1&M2&M3&!I1&I2 | !M1&M2&M3&I1&!I2 | !M1&M2&M3&I1&I2 | M1&!M2&!M3 | M1&!M2&M3 | M1&M2&!M3 | M1&M2&M3 | M1&M2&M3 | !M1&!M2&!M3;
  M3p = !M1&!M2&M3&!I2&!I3 | !M1&!M2&M3&!I2&I3 | !M1&!M2&M3&I2&I3 | !M1&M2&!M3&!I1&I3 | !M1&M2&M3&!I1&!I2 | !M1&M2&M3&!I1&I2 | !M1&M2&M3&I1&I2 | M1&!M2&M3 | M1&!M2&M3 | M1&M2&!M3 | M1&M2&M3 | !M1&!M2&!M3;

  M1 = M1p;
  M2 = M2p;
  M3 = M3p;

  Q1 = !M1&!M2&!M3 | M1&!M2&!M3 | M1&!M2&M3;
  Q2 = M1&M2&!M3 | M1&M2&M3;

  digitalWrite(M1Pin, M1);
  digitalWrite(M2Pin, M2);
  digitalWrite(M3Pin, M3);
  digitalWrite(Q1Pin, Q1);
  digitalWrite(Q2Pin, Q2);

  delay(100);
}


