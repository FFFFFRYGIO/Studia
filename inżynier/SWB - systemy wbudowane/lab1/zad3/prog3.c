#include <REGX52.H>

void Delay(void)
{
	unsigned char j;
	unsigned char i;
	for(i=0;i<100;i++)
		for(j=0;j<254;j++);
}

void main (void)
{
	unsigned char zmienna;
	// zmienna temp sluzy do sprawdzania, kiedy zostana
	// zapalone wszystkie diody i trzeba je zgasic 
	bit temp = !P3_2;
	while(1)
  {
		if(!P3_2)
		{
			// Narasta od lewej
			if(temp)
			{
				// Na poczatku
				temp = 0;
				P2 = 255;
				zmienna = 255;
				Delay();
				Delay();
			} else {
				// Kolejne kroki
				zmienna /= 2;
				P2 = zmienna;
				Delay();
				if(zmienna == 0)
					// Jak wszystkie sie zapala, to zerujemy
					temp = 1;
			}
		}
		else
		{
			//Narasta od prawej
			if(!temp)
			{
				// Na poczatku
				temp = 1;
				zmienna = 1;
				P2 = 255;
				Delay();
				Delay();
			} else {
				// Kolejne kroki
				zmienna *= 2;
				P2 = 255 ^ (zmienna-1);
				Delay();
				if((zmienna-1) == 255)
					// Jak wszystkie sie zapala, to zerujemy
					temp = 0;
			}
		}
  }
}