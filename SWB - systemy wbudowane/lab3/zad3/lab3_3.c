#include <REGX52.H>

unsigned char code tab[] = {0xEF, 0xDF, 0xBF, 0x7F};
unsigned char x;
bit success = 1;
unsigned char ccind = 0;
unsigned char code correctCode[] = {	
	0xDD, // k3+w2 6
	0xBB, // k2+w3 8
	0xED, // k3+w1 3
	0xDD  // k2+w2 6
};

void Delay(void)
{
	unsigned char i, j;
	for(i=0;i<190;i++) 
		for(j=0;j<200;j++) {;}
}

void HalfDelay(void)
{
	unsigned char i, j;
	for(i=0;i<190;i++) 
		for(j=0;j<100;j++) {;}
}

void checkCode(void)
{
	if(ccind==4)
	{
		if(success)
		{
			if(P2==0x77) // gwiazdka - error
			{
				for(x=0;x<7;x++)
				{
					if(x==3) //Pauza
					{
						Delay();	
					}
					else //Blysk
					{
						P0_0 = 0;
						HalfDelay();
						P0_0 = 1;
						HalfDelay();	
					}	
				}				
			}
			else if(P2==0x7D) // krzyzyk - otwarcie
			{
				for(x=0;x<6;x++)
				{
					P0_0 = 0;
					HalfDelay();
					P0_0 = 1;
					HalfDelay();		
				}		
			}
		}
		ccind=0;
		success = 1;	
	}
	else
	{
		if(!(P2==correctCode[ccind]))
		{
			success=0;	
		}
		ccind++;
	}		
}

void main (void)
{
	unsigned char data i=0;
	while(1)
	{
		P2=tab[i];
		if(!(P2_1 & P2_2 & P2_3))
		{
			checkCode();
			while(!(P2_1 & P2_2 & P2_3));
		}
		else
		{
			if(i<3)
				i++;
			else
				i=0;
		}	
	}	
}
