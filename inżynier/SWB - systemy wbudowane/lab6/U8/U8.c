#include <REGX52.H>

extern void LcdInit();
extern void LcdWelcome();
extern void Lcd_Cursor(char row, char column);
extern void Lcd_DisplayCharacter(char a_char);
extern void Lcd_DisplayString(char row, char column, char *string);
extern void Lcd_WriteControl(unsigned char LcdCommand);

unsigned char data Var1, Var2, Var3;
volatile unsigned char data Title[] = {"Odczyt ASCII   "};

unsigned char curr_char;
unsigned char pos;
unsigned char temp;

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
	
    EA=1;
    TR2=1;
}

void display_new(unsigned char c)
{
	Lcd_Cursor(2, 10);
	Lcd_DisplayCharacter(c);

    // Dec
    pos = 13;
    temp = c;

	if(c>=100)
    {
        Lcd_Cursor(3, pos++);
        Lcd_DisplayCharacter ('0' + temp/100);
        temp = temp%100;
    }
    if(c>=10)
    {
        Lcd_Cursor(3, pos++);
        Lcd_DisplayCharacter ('0'+ temp/10);
        temp = temp%10;
    }
    if(c>=0)
    {
        Lcd_Cursor(3, pos++);
        Lcd_DisplayCharacter ('0'+ temp);
    }

    // Hex
    pos = 13;
    temp = c;

	if(c>=16)
    {
        Lcd_Cursor(4, pos++);
        if(temp/16 >= 10)
            Lcd_DisplayCharacter ('A' + temp/16 - 10);
        else
            Lcd_DisplayCharacter ('0' + temp/16);
        temp = temp%16;
    }
    if(c>=0)
    {
        Lcd_Cursor(4, pos++);
        if(temp >= 10)
            Lcd_DisplayCharacter ('A' + temp - 10);
        else
            Lcd_DisplayCharacter ('0' + temp);
    }
}

void main(void)
{
	LcdInit();
	init();
	LcdWelcome();
    Lcd_DisplayString(1, 1, Title);
	Lcd_Cursor(2,10);
	while(1){;}

}

void ISR_Serial(void) interrupt 4 
{
    if(TI==1){TI=0;}
    if(RI==1)
    {
    if(SBUF != curr_char)
    {
        display_new(SBUF);
        curr_char = SBUF;
    }
    RI=0;
    }
}
