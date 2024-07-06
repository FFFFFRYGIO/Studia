// przerwania1
//

#include <REGX52.H>

sbit LEDZielona = P2^0; // mrugaj od przerwania od licznika
sbit LEDZolta = P2^7; // mrugaj od przycisku
sbit SW = P3^2;

void timer0_isr() interrupt 1
{
TH0 = 0XC3; //zaladuj od nowa wybrana TH0
TL0 = 0X40;
LEDZielona =!LEDZielona; // Zmien stan diody zielonej
}

void main()
{
   SW = 1; //SW ma pracowac jako wejscie
   TMOD = 0x01; //Timer0 mode 1 czyli timer 16-bitowy => zakres 0 - 65 535
   TH0 = 0XC3; //Zaladuj wybrana wartosc TH0
   TL0 = 0X40;
   ET0 = 1; //Enable Timer0 Interrupt
   EA = 1; //Enable Global Interrupt bit
   TR0 = 1; // ON Timer0
        while(1)
          {
       LEDZolta= SW; //Stan przycisku na diodzie zoltej
    }
}
