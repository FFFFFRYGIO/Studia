#include <REGX52.H>

 sbit clkM = P2^0; // Pierwszy bit mastera - zegar
 sbit dtaM = P2^1; // Drugi bit mastera - dane
 sbit clkS = P2^2; // Pierwszy bit slave'a - zegar
 sbit dtaS = P2^3; // Drugi bit slave'a - dane

 bit bM = 1; // Flaga sprawdzajaca czy wcisniety zostal przycisk
 int dt = 10; // Wartosc opoznienia do funkcji czekaj()
 int tt = 100; // Wartosc opoznienia do funkcji czekaj()

 volatile unsigned char liczbaM = 0x00;
 unsigned char liczbaS = 0x00;
 unsigned char bajt = 0x00;

 void czekaj(int i) // Wykonuje operacje wymuszajace wstrzymanie reszty programu
 {
	unsigned int k, l, m;
	for (l = 0; l < i; l++) // Wykonuje zestaw zlozonych czasowo operacji
	{
		k = 500;
		m = 1000;
		k = m * l;
	}
 }

 void liczInt0() interrupt 0 // W przypadku przerwania
 {
 	EX0 = 0; // Wylacza przerwanie
	liczbaM++; // Zwieksza liczbe do wyswietlenia
	if (liczbaM == 255)
		liczbaM = 0; // Zachowanie cyklicznosci, nastepna po maksymalnej mozliwej wartosci to 0
	EX0 = 1; // Wylacza przerwania
	bM = 0; // Zmiana flagi przycisku
 }

 void zapiszBajt(unsigned char bajt)
 {
	unsigned char liczbaBitow = 8; 	
	
	do 
	{
		dtaM = bajt & 0x80; // Wartosc wyjsciowa na port P1
		czekaj(dt);
		czekaj(tt);
		clkM = 0; // Zmiana zegara na 0 (master)
		czekaj(tt);
		clkM = 1; // Zmiana zegara na 1 (master)
		czekaj(tt);
		bajt = (bajt << 1) + 1; // przesuniecie bajtu o 1
	} while(--liczbaBitow); // Wykonuje operacje po calym bajcie
	clkM = 1; // Zmiana zegara na 1 (master)
	dtaM = 1; // Dana wynosi 0
 }

 unsigned char czytajBajt() // Odczytaj wiadomosc z mastera
 {
	unsigned char liczbaBitow = 8; 	
	unsigned char wynik = 0; 	
	do 
	{
		while(clkS == 1) // Dopoki zegar wynosi 1 (slave)
		{
			czekaj(dt);
		}
		wynik = wynik << 1; // przesuniecie wartosci binarnej o 1
		if(dtaS)
			wynik ++; // Jesli jest niezerowa dana zwieksz wynik
		while(clkS == 0)
		{
			czekaj(dt);
		}
	} while(--liczbaBitow); // Wykonuj po calym bajcie
	return wynik; // Po zakonczeniu petli mamy odkodowana cala dana
 }

 void initInt0() // Podane na odpowiednie wejscia poczatkowe wartosci
 {
 	liczbaM = 0; // Poczatkowa wartosc wyjscia
	IT0 = 1; // INT0 aktywne zero
	EX0 = 1; // Wlaczenia INT0
	EA = 1; // Wlaczenie wszstkich przerwan
 }

 void main()
 {
 	initInt0(); // Uzupelnij poczatkowymi wartosciami
	P1 = 0; // Na poczatku licznik wynosi 0
	clkM = 1; // Inicjalizacja zegara
	dtaM = 1; // Inicjalizacja transmisji (na razie bez danych)

	// Wykonuje sie albo master, albo slave
	// Master czeka na wcisniecie przycisku, zeby wyslac dana
	// Slave czeka na sygnal od mastera, zeby zaczac odczytywac dana

	while (P0_0 == 1) //MASTER
	{
		while(bM) // Dopoki przycisk nie jest wcisniety czekaj
		{
			czekaj(dt);
		}
		P1 = liczbaM; // Zwieksz wartosc wyswietlana na masterze
		zapiszBajt(liczbaM); // Zapisz bajt i wyslij do slave'a
		bM = 1; // Wiadomosc wyslana, zmiana flagi, zeby czekac na ponowne wyslanie przycisku
	}

	while (P0_0 == 0) //SLAVE
	{
		while(clkS == 1) // Dopoki nie ma sygnalu o transmicji czekaj
		{
			czekaj(dt);
		}
		liczbaS = czytajBajt(); // Odczytaj otrzymana wartosc
		P1 = liczbaS; // Wyswietl odczytana wartosc
	}
 }
