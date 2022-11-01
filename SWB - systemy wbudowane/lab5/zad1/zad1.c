//PWM_Przyklad
// zmiana wspolczynnika wypelnienia
// zmiana czestotliwosci impulsow PWM (Pulse Width Modulation)

#include <REGX52.H>

// PWM_Pin
sbit PWM_Pin = P2^0;		   // Pin P2.0 to PWM_Pin

// deklaracje
void InitTimer0(void);
void InitPWM(void);

// zmienne globalne
unsigned char PWM = 94;	  // wartosc od 0 (0% duty cycle) do 255 (100% duty cycle)
unsigned int temp = 0;    // zmienna robocza w procedurze obs³ugi przerwania Timer0


#define PWM_Freq_Num   40	 //  1 = najwyzsza czestotliwosc gdy PWM_Freq_Num, zakres 1 - 255


// Main Function
int main(void)
{
   InitPWM();              // Start PWM
 
   PWM = 94;              // 127 = 50% wspolczynnik wypelnienia

   while(1) {;}
}


// Timer0 init
void InitTimer0(void)
{
	TMOD &= 0xF0;    // wyzeruj bity dla Timer0
	TMOD |= 0x01;    // ustaw tryb mode 1 = 16bit mode
	
	TH0 = 0x00;      // Pierwsze
	TL0 = 0x00;      // ustawienie
	
	ET0 = 1;         // Enable Timer0 interrupts
	EA  = 1;         // Enable All
	
	TR0 = 1;         // Start Timer 0
}

// PWM init
void InitPWM(void)
{
	PWM = 0;         // poczatkowo zero
	InitTimer0();    // Init Timer0 dla rozpoczecia generacji przerwan
}

// Timer0 ISR
void Timer0_ISR (void) interrupt 1   
{
	TR0 = 0;    // Stop Timer 0

	if(PWM_Pin)	// if PWM_Pin =1 wyzeruj sygnal PWM i zaladuj licznik
	{
		PWM_Pin = 0;
		temp = (255-PWM)*PWM_Freq_Num;
		TH0  = 0xFF - (temp>>8)&0xFF;
		TL0  = 0xFF - temp&0xFF;	
	}
	else	     // if PWM_Pin =0 ustaw pin na 1 i zaladuj licznik
	{
		PWM_Pin = 1;
		temp = PWM*PWM_Freq_Num;
		TH0  = 0xFF - (temp>>8)&0xFF;
		TL0  = 0xFF - temp&0xFF;
	}

	TF0 = 0;     // wyczysc flage
	TR0 = 1;     // Start Timer 0
}