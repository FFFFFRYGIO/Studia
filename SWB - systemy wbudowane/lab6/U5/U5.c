#include <REGX52.H>

#define en2 P2_4
#define in3 P2_5
#define in4 P2_6
#define en1 P2_3
#define in1 P2_1
#define in2 P2_2

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

unsigned char PWM = 1; //255*0.5;	  // wartosc od 0 (0% duty cycle) do 255 (100% duty cycle)
unsigned int temp = 0;    // zmienna robocza w procedurze obslugi przerwania Timer0
#define PWM_Freq_Num 30	 //  1 = najwyzsza czestotliwosc gdy PWM_Freq_Num, zakres 1 - 255

unsigned char get_char;
bit is_moving_left_up = 0;
bit lighst_off = 0;

void recive(void) interrupt 4
{
    // Odbior znaku
		if(TI==1){TI=0;}
    if(RI==1)
    {
    get_char = SBUF;
    RI=0;
    }
		
		if(get_char==Koder[9]) // * - wlacz/wylacz zarowki
		{
			lighst_off = !lighst_off;
		}
		else if(get_char==Koder[11]) // # - zmiana kierunku obiotow
		{
			if(!lighst_off)
				{in1 = !in1; in2 = !in2;}
			in3 = !in3; in4 = !in4;
			is_moving_left_up = !is_moving_left_up;
		}
		else if (get_char%2) // nieparzysta - ruch w lewo w gore
		{
			if(!lighst_off)
				{in1 = 0; in2 = 1;}
			in3 = 0; in4 = 1;
			is_moving_left_up = 1;
			
			en1 = 1; en2 = 1;
		}
		else // parzysta - ruch w prawo w dol
		{
			if(!lighst_off)
				{in1 = 1; in2 = 0;}
			in3 = 1; in4 = 0;
			is_moving_left_up = 0;
			
			en1 = 1; en2 = 1;
		}
}

void handle_PWM(void) interrupt 3   {
	P1 = 0;
	TR1=0;
	if(en2){
		en2=0;
		temp=(255-PWM)*PWM_Freq_Num;
		TH1=0xFF-(temp>>8)&0xFF;
		TL1=0xFF-temp&0xFF;	
	}else{
		en2=1;
		temp=PWM*PWM_Freq_Num;
		TH1=0xFF-(temp>>8)&0xFF;
		TL1=0xFF-temp&0xFF;
	}
	TF1=0;
	TR1=1;
}


void handle_engine(void) interrupt 0{
	if(lighst_off) // Dla wylaczonych
		{in1 = 0; in2 = 0;}
	else
	if(is_moving_left_up)	// Dla obrotow w lewo
	{
		in1 = 1;
		in2 = !in2;
	}
	else	// Dla obrotow w prawo
	{
		in2 = 1;
		in1 = !in1;
	}
}

void init(void){
		P2 = 0; // Na poczatku silnik i zarowki nie dzialaja
	
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

		// timer1 - interrupt 3, do obslugi PWM
		TCON=0x00;
		TMOD=TMOD & 0x0F;
		TMOD=TMOD | 0x20;
		TL1=TH1=0x00;
		ET1=1;

		IT0=1;
		EX0=1;

    EA=1;
    TR2=1;
		
		TR1 = 1;
}

void main (void){
	init();
	while(1){;}
}
