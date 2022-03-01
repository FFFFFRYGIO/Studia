//Program takes a decimal float number from 0 to 1 and converts it to binary number
//Digits of converted number are stored in a bidirectional list
//Converted numbers with a periodic expansion uses a recurring list mechanizm, so it can display infinite number of digits
#include <stdio.h>

typedef struct element
    {
        int digit;
        float mantissa;
        struct element *next;
	    struct element *prev;
        struct element *next2;
    }element;

element *head = NULL;
element *tail = NULL;

void add_element(float mantissatmp)
{
	element *new=NULL;
	int digittmp = mantissatmp;
	new = (element*) malloc(sizeof(element));
	new -> digit = digittmp;
	if(mantissatmp >= 1)
		mantissatmp--;
	new -> mantissa = mantissatmp;
	
	printf("\t%i\t%f", new -> digit, new -> mantissa);
	if (head == NULL)
        {
            new -> next = NULL;
            new -> prev = NULL;
            head = new;
            tail = new;
        }
        else
        {
            new -> next = NULL;
            new -> prev = tail;
            tail -> next = new;
            tail = new;
        }
    printf("\n");
}

int is_periodic(float mantissatmp)
{
	element *find = NULL;
	find = head;
	while(find != NULL)
	{
		//Cleaning float
		float tempF = mantissatmp * 10;
		int tempI = tempF;
		mantissatmp = 1.0 * tempI / 10;
		
		if(find->mantissa == mantissatmp)
		{
			tail->next2 = find;
			return 1;
		}
		find = find->next;
	}
	return 0;
}


void con2b(float ptr)
{
	printf("Converting decimal fraction to binary fraction\n");
    float mantissatmp = ptr;
	int digittmp;
	int i,if_continue = 1;
	while(if_continue)
	{
        mantissatmp *= 2;
        if(is_periodic(mantissatmp))
		{
			if_continue = 0;
			printf("\tPedioric binary fraction\n");
		}
		else
			add_element(mantissatmp);
		if(mantissatmp >= 1)
			mantissatmp--;
		if(mantissatmp == 0.0)
			if_continue = 0;	
		
	}
	printf("End of conversion\n");
}

void print_all()
{
    element *display = NULL;
    display = head;
    int l_porz = 1;
    printf("-------------------------------\n");
    while(display != NULL)
    {
        printf("Digit number %i\n",l_porz);
        printf("Digit : %i\n",display->digit);
        printf("Mantissa : %f\n",display->mantissa);
        printf("Adress of previous element: %i\n",display->prev);
        printf("Adress of this element: %i\n",display);
        printf("Adress of next element: %i\n",display->next);
        printf("Adress of elternative next element: %i\n",display->next2);
        printf("-------------------------------\n");
        display = display->next;
        l_porz++;
    }
    printf("These are all digits of a number or there is a cykle\n");
    printf("-------------------------------\n");
}

void sBtD(float ptr, int n)
{
	printf("Printing number:\n");
	element *display = NULL;
    display = head;
    printf("0.");
    while(display != NULL && n--)
    {
    	printf("%i",display->digit);
    	if(display->next2 != NULL)
    		display = display->next2;
    	else
    		display = display->next;
	}
    printf("\nFinished");
}

int main()
{
    //Input number
    float liczbaDEC;
    while(1)
    {
        printf("Input decimal fraction (start with '0.'): ");
        scanf("%f", &liczbaDEC);
        int liczbatmp = liczbaDEC;
        if(liczbatmp)
            printf("Wrond number!\n");
        else
            break;
    }

	con2b(liczbaDEC);
    print_all();
    int n;
    printf("Input number of digits to display: ");
    scanf("%i", &n);
    sBtD(liczbaDEC,n);
    
    return 0;
}
