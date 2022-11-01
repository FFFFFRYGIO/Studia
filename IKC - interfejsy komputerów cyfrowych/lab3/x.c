#include <REGX52.H>

volatile unsigned char liczba = 0;
unsigned char bM = 1;

void delay()
{
	unsigned char i, j;
	for(i = 0; i < 255; i++)
	{
		for(j = 0; j < 200; j++);
	}
}

void countInt0() interrupt 0
{
	// Dla mastera, zwieksza wartosc
	EX0 = 0;
	liczba = (liczba + 1) % 100;
	EX0 = 1;
	bM = 0;
}

void main(void)
{
	IT0 = 1; // INT0 aktywne zero
	EX0 = 1; // Wlaczenia INT0
	EA = 1; // Wlaczenie wszstkich przerwan
	if (P0_0 != 0)
	{
		// MASTER
		P1 = 0x00;
		P2 = 0xFF;
		while(1)
		{
			// Czekaj na wcisniecie
			while(bM);
			// Wypisz nowa liczbe
			P1 = liczba/10 * 16 + liczba%10;
			// Wyslij sygnal do slave'a o wysylaniu
			P0_6 = 0;
			// Wyslij liczbe
			P2 = liczba;
			// Czekaj
			delay();
			// Wyslij sygnal do slave'a o koncu wysylania
			P0_6 = 1;
			// Czekaj na informacje zwrotna od slavea
			while(P0_7 == 1);
			P2 = 0xFF;
			// Zwalnia przycisk
			bM = 1;
		}
	} 
	else
	{
		// SLAVE
		P1 = 0x00;
		while(1)
		{
			// Wypisz liczbe - poczatkowo 0
			P1 = liczba/10 * 16 + liczba%10;
			// Czekaj na sygnal od mastera
			while(P0_4 == 1);
            // Wyslij do mastera informacje o odbieraniu sygnalu
			P0_5 = 0;
			// Wczytaj liczbe od mastera
			liczba = P2;
			// Odczekaj
			delay();
			// Wyslij informacje o koncu odbierania
			P0_5 = 1;
		}
	} 
}