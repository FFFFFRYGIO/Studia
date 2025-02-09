
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>  

struct Node	{
		char dane;
		struct Node *next;
	};
typedef struct Node *NodePtr;

 
/* Deklaracja funkcji dodajacej element do nieuporz¹dkowanej
   listy jednokierunkowej */
int DodajElm (NodePtr *startPtr, char WstZnak) {
	struct Node *newPtr, *currPtr;
/* Utwórz element Node */
    newPtr = (struct Node *)malloc(sizeof(struct Node));
	if (newPtr == NULL)  /* weryfikacja przydzielonej pamiêci*/ 
		return 1;
	else 
	{   /* Ustal dane elementarne w Node */
		newPtr -> dane = WstZnak;
		newPtr -> next = NULL;

        if (*startPtr == NULL)
		/* Wstaw element jako pierwszy w liœcie */
       			*startPtr = newPtr;
        else
        {
           currPtr = *startPtr;   /* ustaw wskaŸnik na g³owê listy */
 		   // Wstaw element na koñcu listy
		   while (currPtr->next != NULL)
   				currPtr = currPtr -> next;
            currPtr->next = newPtr;
         }
     }
		return 0;
}


int main(void)
{
NodePtr poczListy; char Znak;
struct Node *biezacyPtr, *elementPtr;	

 // Tworzenie listy
	poczListy=NULL;
	printf("Wprowadz znak\n");
	Znak=getche();
	while (Znak!='/') {
		DodajElm(&poczListy, Znak);
		printf("\nWprowadz kolejny znak\n");
		Znak=getche();
	}
	printf("\nKoniec tworzenia listy");

//Przegl¹danie listy
	biezacyPtr=poczListy;
 	printf("\nPrzegladanie listy\n");
	while (biezacyPtr!=NULL) {
        Znak=biezacyPtr->dane;
		printf("%c\n",Znak);
		biezacyPtr=biezacyPtr->next;
	}
	printf("Koniec przegladania listy");
    getche();
	return 0;
}


