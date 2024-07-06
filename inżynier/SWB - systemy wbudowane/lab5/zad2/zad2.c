//PWM_Przyklad
// zmiana wspolczynnika wypelnienia
// zmiana czestotliwosci impulsow PWM (Pulse Width Modulation)

#include <REGX52.H>

sbit IN1_Pin = P2^1;
sbit IN2_Pin = P2^2;
sbit PWM_Pin = P2^3;
sbit PWMl_Pin = P2^4;
sbit IN3_Pin = P2^5;
sbit IN4_Pin = P2^6;



// zmienne globalne
bit stop = 1;
unsigned char PWM = 0; // wartosc od 0 (0% duty cycle) do 255 (100% duty cycle)
unsigned int temp = 0; // zmienna robocza w procedurze obs³ugi przerwania Timer0


#define PWM_Freq_Num 40 // 1 = najwyzsza czestotliwosc gdy PWM_Freq_Num, zakres 1 - 255

void handlebutton() interrupt 2
{
    stop = !stop;
    PWM_Pin = 0;
    PWMl_Pin = 0;
}

void InitTimer0(void)
{

    IT1 = 1; // INT1 aktywne zero
    EX1 = 1; // Wlaczenia INT1

	TMOD &= 0xF0;    // wyzeruj bity dla Timer0
	TMOD |= 0x01;    // ustaw tryb mode 1 = 16bit mode
	
	TH0 = 0x00;      // Pierwsze
	TL0 = 0x00;      // ustawienie
	
	ET0 = 1;         // Enable Timer0 interrupts
	EA  = 1;         // Enable All
	
	TR0 = 1;         // Start Timer 0
}

int main(void)
{
    InitTimer0(); // Init Timer0 dla rozpoczecia generacji przerwan
    IN1_Pin = 0;
    IN2_Pin = 1;
    PWM_Pin = 0;

    IN3_Pin = 0;
    IN4_Pin = 1;
    PWMl_Pin = 0;

    PWM = 69;
    while(1) {;}
}

void Timer0_ISR (void) interrupt 1
{
    TR0 = 0; // Stop Timer 0
    if(PWM_Pin) // if PWM_Pin =1 wyzeruj sygnal PWM i zaladuj licznik
    { 
        temp = (255 - PWM) * PWM_Freq_Num;
        TH0 = 0xFF - (temp >> 8) & 0xFF;
        TL0 = 0xFF - temp & 0xFF;
    }
    else // if PWM_Pin =0 ustaw pin na 1 i zaladuj licznik
    { 
        temp = PWM * PWM_Freq_Num;
        TH0 = 0xFF - (temp >> 8) & 0xFF;
        TL0 = 0xFF - temp & 0xFF;
    }
    if(!stop)
    {
        PWM_Pin = !PWM_Pin;
        PWMl_Pin = !PWMl_Pin;
    }

    TF0 = 0; // wyczysc flage
    TR0 = 1; // Start Timer 0
}
