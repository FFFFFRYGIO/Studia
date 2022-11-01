#include <REGX52.H>

unsigned char zmiennaAA=0;
unsigned char granica=5+9;
unsigned char krok=1;
unsigned char numer=9;
unsigned char stanP;

void wyswietl(void)
{
	// wyswietlanie
	if(zmiennaAA==0)
	{
		P2=0xFF;
	}
	else if(zmiennaAA%2)
	{
		P2 = numer * 0x10 + (zmiennaAA%10); 
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
}

void main (void)
{
	stanP=P3_2;
	wyswietl();
	while(1)
	{
		if(stanP==0 && P3_2)
		{
			wyswietl();	
		}
		stanP=P3_2;		
	}
}
