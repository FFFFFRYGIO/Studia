#include <REGX52.H>    // plik nagl. rej. procesora

#define Port P2
#define No_Key 0x0C
#define Key_is_Off P3_2==1
#define ON  0
#define OFF 1

volatile unsigned char data ind; // indeks wiersza klawiatury, musi byc globalny, uzywany w proc IRQ
sbit Led = P0^0;

void Init(void)						// Funkcja inicjujaca elementy wewnetrzne uC
{
    TMOD = 0x22;          // Konfiguracja Timera 1                      
    TH1  = 0x00;          // konfiguracja Timera 1
    TL1  = 0x00;          // konfiguracja Timera 1
    TCON = 0x10;          // konfiguracja Timera 1
    ET1  = 1;             // dolaczenie przerwania od Timer1 do systemu przerwan

    EX0 = 1;              // wlaczenie przerwania od INT0
    IT0 = 1;              // przerwanie aktywne zboczem opadajacym

//    SCON  = 0x40;         // serial control - 8-Bit var. Baud Rate
//    TCLK  = 1;            // dolacz taktowanie do nadajnika portu szeregowego
//    T2CON = 0x10;         // Timer2 jako Baud Rate Generator 2400b/sek
//    RCAP2H = TH2 = 0xFF;  // wartosc poczatkowa licznika T2 - czesc H
//    RCAP2L = TL2 = 0xEE;  // wartosc poczatkowa licznika T2 - czesc L
//    TR2 = 1;              // uruchom Timer 2 - taktowanie nadajnika RS
    TR1 = 1;              // wlaczenie timera 1
    EA = 1;    	          // wlaczenie systemu przerwan
}

//unsigned char Szukaj(unsigned char Kod_przycisku) // zamiana scankodu na dowolny kod ASCII
//{
//    unsigned char data Value, licznik;                               // zmienne pomocnicze
//    unsigned char code Koder[] = {0xE7, 0xEB, 0xED, 0xD7, 0xDB, 0xDD,
//                                  0xB7, 0xBB, 0xBD, 0x7B, 0x77, 0x7D};    // tablica scankodow
//    unsigned char code New_Char[] = {'1','2','3','4','5','6',
//                                     '7','8','9','0','*','#'}; // tablica kod?w ASCII
//
//    licznik=0x00;                                                    // zacznij od poczatku
//    while((Koder[licznik]!=Kod_przycisku)&(licznik<No_Key)){licznik++;} // znajdz scankod
//    Value = No_Key;
//    if(licznik!=No_Key){Value = New_Char[licznik];}                  // przypisz kod ASCII
//    return Value;                                                    // zwroc kod ASCII lub No_Key
//}

void ISR_Timer1 (void) interrupt 3 	// Timera 1 - generacja krazacego zera na porcie P2
{
unsigned char code Kod[] = {0xEF, 0xDF, 0xBF, 0x7F};     // skanuj kolejne wiersze klawiatury
            
Port = Kod[ind];                                      // wystawienie zera na port
if(Key_is_Off) {if(ind<3) {ind++;} else {ind=0;}} // Wazne, bramka wprowadza opoznienie 10ns.
// Zmiana indeksu tablicy generowana jest tylko
// wtedy, gdy zaden przycisk nie jest wcisniety
}

void sleep(void)              // odczekaj chwile
{
    unsigned char data x,y;
    for(x=0;x<190;x++)
        for(y=0;y<100;y++){;}
}

//void sleep_half(void)              // odczekaj chwile
//{
//    unsigned char data x,y;
//    for(x=0;x<190;x++)
//        for(y=0;y<50;y++){;}
//}

void ISR_INT0 (void) interrupt 0	  // INT0 - wylapywanie wcisnietych przycisku
{
unsigned char data Key, j, kodWiersza, wiersz;  // zmienne pomocnicze
TR1=0;               // wylacz timer 1
Key = Port;               // pobranie kodu klawisza
//Value = Szukaj(Key);     // okresl kod ASCII przycisku
//if(Value!=No_Key)        // wykonaj jesli kod ASCII jest prawidlowy
//{
//Led=0;
//sleep_half();
//Led=1;
//sleep();

kodWiersza=(Key/16);
if(kodWiersza==0xE) wiersz=1;
else if(kodWiersza==0xD) wiersz=2;
else if(kodWiersza==0xB) wiersz=3;
else if(kodWiersza==0x7) wiersz=4;

for(j=0; j<wiersz; j++){
Led=0;
sleep();
Led=1;
sleep();
}
sleep();
sleep();
Led=0;
sleep();
Led=1;

EX0 = 0;             // wylacz przerwanie INT0 (czytanie przyciskow)
//TI = 0;             // przygotuj wysylanie znakow
//SBUF = Value;      // Obsluga: transmisja znaku portem szeregowym
//while(TI==0){;}    // odczekaj dopoki znak jest transmitowany
IE0 = 0;             // na wszelki wypadek wygas flage przerwania od INT0
EX0 = 1;             // wlacz obsluge INT0
//}
TR1=1;                  // wlacz timer 1
}
void Default(void)
{
    ind  = 0;              // indeks wiersza klawiatury
    Port = P2;              // inicjowanie portu klawiatury
}

void main(void)  // program glowny
{
    Default();   // inicjowanie zmiennych
    Init();      // inicjowanie urzadzen wewnetrznych
    while(1) {;} // pusta petla programu, a program dziala :)
}
