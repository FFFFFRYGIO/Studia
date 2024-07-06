#include <REGX52.H>

unsigned char code tab[] = {0xEF, 0xDF, 0xBF, 0x7F};
unsigned char bdata key;
sbit k1 = key^1;
sbit k2 = key^2;
sbit k3 = key^3;
sbit k4 = key^4;
sbit k5 = key^5;
sbit k6 = key^6;
sbit k7 = key^7;

void Delay(void)
{
	unsigned char i, j;
	for(i=0;i<190;i++) 
		for(j=0;j<200;j++) {;}
}

void main (void)
{
	unsigned char data i = 0, flashes;
	bit Enabled = 1;
	while(1)
	{
		P2 = tab[i];
		key = P2;
		if(!(k1 & k2 & k3))
		{
			if (Enabled)
			{
				// Wiersze
				if(!k4) flashes = 1;
				else if(!k5) flashes = 2;
				else if(!k6) flashes = 3;
				else if(!k7) flashes = 4;
				while(flashes--)
				{
					P0_0 = 0;
					Delay();
					P0_0 = 1;
					Delay();
				}
				Delay(); Delay();
				// Kolumny
				if(!k3) flashes = 1;
				else if(!k2)  flashes = 2;
				else if(!k1) flashes = 3;
				while(flashes--)
				{
					P0_0 = 0;
					Delay();
					P0_0 = 1;
					Delay();
				}
				Enabled = 0;
			}
		} else
		{
			if (i < 3) 
				i++;
			else 
				i = 0;
			Enabled = 1;
		}
	}
}
