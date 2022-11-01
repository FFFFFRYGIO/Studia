#include <REGX52.H>

void Delay(void)
{
	unsigned char j;
	unsigned char i;
	for(i=0;i<100;i++)
	{
		for(j=0;j<100;j++){};
	}
}

unsigned char zmiennaAA=0;
unsigned char granica = 5+9;
unsigned char krok = 1;

void wyswietl(unsigned char liczba)
{
	unsigned char wypisz = 0xFF;
	if(liczba%10)
	{
		wypisz = wypisz ^ (liczba/10 * 0x10);	
	}
	wypisz = wypisz ^ (liczba%10);
	P2=0xFF-wypisz;
}

void main(void)
{
	while(1)
	{
		// wyswietlanie
		if(zmiennaAA==0)
		{
			P2=0xFF;
			Delay();
		}
		else if(zmiennaAA%2)
		{
			wyswietl(zmiennaAA);
		}
		//iteracja
		if(zmiennaAA>=granica)
		{
			zmiennaAA=0;	
		}
		else
		{
			zmiennaAA+=krok;	
		}
		Delay();		
	}
}