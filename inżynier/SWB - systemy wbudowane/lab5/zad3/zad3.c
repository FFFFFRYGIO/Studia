//PWM_Przyklad
// zmiana wspolczynnika wypelnienia
// zmiana czestotliwosci impulsow PWM (Pulse Width Modulation)

#include <REGX52.H>

sbit IN1_Pin = P2^1;
sbit IN2_Pin = P2^2;
sbit PWM_Pin = P2^3;

// zmienne globalne
unsigned char PWM = 0; // wartosc od 0 (0% duty cycle) do 255 (100% duty cycle)
unsigned int temp = 0; // zmienna robocza w procedurze obs³ugi przerwania Timer0

#define PWM_Freq_Num 40 // 1 = najwyzsza czestotliwosc gdy PWM_Freq_Num, zakres 1 - 255

unsigned char c0 = 0; // Counter0 - dla Timer0
unsigned char c1 = 0; // Counter1 - dla Timer1

void handlebuttonI0() interrupt 2
{
    IN1_Pin = IN2_Pin;
	IN2_Pin = !IN2_Pin;
}

void handlebuttonT0() interrupt 1
{
	TH0 = 0xFF;
	TL0 = 0xFF;
	TF0 = 0;
	
	c0++;
	c1=0;
	if(c0==2){
		TR2=1; // Wlacz silnik
		PWM_Pin = 0;
	}
}

void handlebuttonT1() interrupt 3
{
	TH1 = 0xFF;
	TL1 = 0xFF;
	TF1 = 0;
	
	c1++;
	c0=0;
	if(c1==3){
		TR2=0; // Wylacz silnik
		PWM_Pin = 0;
	}
}

int main(void)
{
    EA = 1; // Wlacz interrupty
	IT1 = 1; // INT1 aktywne zero
    EX1 = 1; // Wlaczenia INT1

	T2CON = 0x04; // tryb timera2
	//timer2
	TH2 = 0x00;
	TL2 = 0x00;
	ET2 = 1;
	TR2 = 0;

	TMOD = 0x55; // tryb licznikow
	// lciznik0
	TH0 = 0xFF;
	TL0 = 0xFF;
	TF0 = 0;
	ET0 = 1;
	TR0 = 1;
	//licznik1
	TH1 = 0xFF;
	TL1 = 0xFF;
	TF1 = 0;
	ET1 = 1;
	TR1 = 1;

    IN1_Pin = 0;
    IN2_Pin = 1;
    PWM_Pin = 0;

    PWM = 69;
    while(1) {;}
}

void Timer2_ISR(void) interrupt 5
{
	TR2 = 0; // stop Timer 2
	if(PWM_Pin) {
		temp = (255 - PWM) * PWM_Freq_Num;
		TH2  = 0xFF - (temp >> 8) & 0xFF;
		TL2  = 0xFF - temp & 0xFF;
	} else {
		temp = PWM * PWM_Freq_Num;
		TH2  = 0xFF - (temp >> 8) & 0xFF;
		TL2  = 0xFF - temp & 0xFF;
	}
	PWM_Pin = !PWM_Pin;
	TF2 = 0; // wyczysc flage
	TR2 = 1; // start Timer 2
}