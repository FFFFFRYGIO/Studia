#include <REGX52.H>

unsigned char code tab[] = {0xEF, 0xDF, 0xBF, 0x7F};

unsigned char code Koder[] = {
	0x31, // 1
	0x32, // 2
	0x33, // 3
	0x34, // 4
	0x35, // 5
	0x36, // 6
	0x37, // 7
	0x38, // 8
	0x39, // 9
	0x2A, // *
	0x30, // 0
	0x23, // #
};

unsigned char c;
unsigned char temp;
unsigned char row;
unsigned char col;
unsigned char x = 128;
unsigned char q;

void Delay(void)
{
	unsigned char i, j;
	for(i=0;i<100;i++) 
		for(j=0;j<50;j++) {;}
}

void smallDelay(void)
{
	unsigned char i, j;
	for(i=0;i<100;i++) 
		for(j=0;j<10;j++) {;}
}

void print_char(void)
{
    // Pobierz wiersz
		if(!(P2_4)) row=0;
    else if(!(P2_5)) row=1;
    else if(!(P2_6)) row=2;
    else if(!(P2_7)) row=3;

	  // Pobierz kolumne
		if(!(P2_3)) col=0;
    else if(!(P2_2)) col=1;
    else if(!(P2_1)) col=2;
		
    c = Koder[row*3+col];
		temp = c;
		
    for(q=0; q<8; q++)
    {
        if(temp>=x) // 1 bin
        {
            P0_0 = 0;
            Delay();
            P0_0 = 1;
            smallDelay();
            temp -= x;
        }
        else // 0 bin
        {
            P0_0 = 0;
            smallDelay();
            P0_0 = 1;
            Delay();
        }
        x /= 2;
    }
		x = 128;
}

void init(void)
{
    P3_4=0;
    SCON=0x50;
    T2CON=0x30;
    TH2=0xFF;
    TL2=0xDC;
    RCAP2H=0xFF;
    RCAP2L=0xDC;
    EA=1;
    TR2=1;
}

void send(unsigned char value)
{
	P3_4=1;
	TI=0;
	SBUF=value;
	while(TI==0){;}
	TI=0;
	P3_4=0;
}

void main (void)
{
	unsigned char data i=0;
	init();
	while(1)
	{
		P2=tab[i];
		if(!(P2_1 & P2_2 & P2_3))
		{
			print_char();
      send(c);
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
