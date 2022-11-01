#include <REGX52.H>

unsigned char code tab[] = {0xEF, 0xDF, 0xBF, 0x7F};

void Delay(void)
{
	unsigned char i, j;
	for(i=0;i<190;i++) 
		for(j=0;j<200;j++) {;}
}

void main (void)
{
	unsigned char data ind = 0;
	bit Enabled = 1;
	while(1) {
		P2 = tab[ind];
		if(!(P2_1 & P2_2 & P2_3)) {
			if (Enabled) {
				P0_0 = 0;
				Delay();
				P0_0 = 1;
				Enabled = 0;
			}
		} else {
			if (ind < 3) 
				ind++;
			else 
				ind = 0;
			Enabled = 1;
		}
	}
}
