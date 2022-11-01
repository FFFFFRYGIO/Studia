#include <REGX52.H>

void Delay(void) // funkcja okreslajaca dlugosc przerwy miedzy kazda iteracja
{
	unsigned char j;
	unsigned char i;
	for(i=0;i<100;i++)
		for(j=0;j<254;j++);
}

void main (void)
{
	unsigned char zmienna = 1;
	while(1)
  {
  		// Do portu P2 przekazywana jest liczba 1111 1111 pomniejszona o bit
		// tego wyjscia, na ktorym chcemy zwrocic 1, aby dioda sie swiecila  
		P2 = (255 - zmienna);
		Delay();
		if(zmienna == 128)
			// jesli swieci pierwsza po lewej, zmien na pierwsza z prawej
			zmienna = 1; 
		else
			// przejdz do nastepnego bitu (o 2 razy wiekszej wartosci decymalnej)
			zmienna *= 2; 
  }
}