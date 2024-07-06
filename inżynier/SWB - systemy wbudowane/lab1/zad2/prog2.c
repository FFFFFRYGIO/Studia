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
	unsigned char zmienna = 128;
	bit temp = 0; // flaga do podwojenia przerwy miedzy co druga iteracja
	while(1)
  {
  		// Chcemy zapalic lampke jak poprzednio oraz na prawo od niej
		// Operacja '^' zaklada przypadek, gdzie chcemy zapalic 2 skrajne, wtedy nie mozemy odejmowac
		P2 = ((255 - zmienna) ^ (zmienna / 2)); 
		Delay();
		if(temp==1)
		{
			// wykonuje sie co druga operacje
			Delay();
			temp=0;
		}
		else
			temp=1;
		// Robimy przeskok na 128 z 2, a nie z 1, zeby
		// pominac krok ze swieceniem sie po obu stronach
		if(zmienna == 2)
			zmienna = 128;
		else
			zmienna /= 2;
  }
}