#include <REGX52.H>

void Delay(unsigned char x)
{
	unsigned char j;
	unsigned char i;
	for(i=0;i<100;i++)
	{
		for(j=0;j<x;j++){};
	}
}

unsigned char zmiennaAA=0;
unsigned char granica=10+9;
unsigned char krok=1;
unsigned char stan;

unsigned char code KoderP[] =
	{0xBF, 0x86, 0xDB, 0xCF , 0xE6 , 0xED , 0xFD , 0x87 , 0xFF , 0xEF};
unsigned char code KoderL[] =
	{0xC0, 0xCF, 0x92, 0x86 , 0x8D , 0xA4 , 0xA0 , 0xCE , 0x80 , 0x84}; 

void operacja(unsigned char q)
{
	if(q)
	{
		if(zmiennaAA>=granica)
		{
			zmiennaAA=0;	
		}
		else
		{
			zmiennaAA+=krok;
		}	
	}
	else
	{
		if(zmiennaAA<=0)
		{
			zmiennaAA=granica;	
		}
		else
		{
			zmiennaAA-=krok;
		}
	}
	P1 = KoderL[zmiennaAA/10];
	P3 = KoderP[zmiennaAA%10];
	Delay(50);
}

void main(void)
{
	stan=P3_7;
	while(1)
	{
		while(P3_7)
		{
			operacja(1); // 1 dla zwiekszania	
		}
		Delay(100);

		while(!P3_7)
		{
			operacja(0); // 0 dla zmniejszania	
		}
		Delay(100);
	}
}