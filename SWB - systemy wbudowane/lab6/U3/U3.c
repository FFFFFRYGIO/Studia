#include <REGX52.H>

unsigned char xdata left _at_ 0xFE00;
unsigned char xdata right _at_ 0xFD00;

unsigned char code Koder[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66,
                              0x6D, 0x7D, 0x07, 0x7F, 0x6F};
unsigned char tLeft=0;
unsigned char tRight=0;
unsigned char get_char = 0x00;

void Delay(void)
{
	unsigned char i, j;
	for(i=0;i<200;i++) 
		for(j=0;j<200;j++) {;}
}

void print(void) interrupt 3
{
    left=Koder[tLeft];
    right=Koder[tRight];
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
	
		// Konfiguracja odbiornika
		ES=1;
    PS=0x10;

		// timer1 - interrupt 3, wyswietlanie
	  TCON=0x00;
    TMOD=TMOD & 0x0F;
    TMOD=TMOD | 0x20;
    TL1=TH1=0x00;
    ET1=1;
	
    EA=1;
		TR1=1;
    TR2=1;

		IT0 = 1;
		EX0 = 1;
}

void reset_with_button(void) interrupt 0
{
		tLeft = get_char/10;
		tRight = get_char%10;
}

void receive(void) interrupt 4
{
    if(TI==1)
        TI = 0;
    if(RI==1){
        RI = 0;
        get_char=SBUF;
    }
		tLeft = get_char/10;
		tRight = get_char%10;
}

void main (void){
    unsigned char i = 0;
    init();
    while(1){
			Delay();
				if(tLeft)
			tLeft--;
		else
			tLeft = get_char/10;
		
		if(tRight)
			tRight--;
		else
			tRight = get_char%10;
		}
}
