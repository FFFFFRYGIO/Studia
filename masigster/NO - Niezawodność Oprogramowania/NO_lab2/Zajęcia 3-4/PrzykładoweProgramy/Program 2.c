#include <stdio.h>
#include <time.h>
#define LWD 6

void MoveDown(int data[ ], int first, int last); 


main() {
int n=LWD, i, Tab[n];
for (i=0; i<n; i++) {
    printf("Podaj liczbe \n");
    scanf("%d",&Tab[i]);
}
for (i=n/2-1;  i>=0;  i--)          // utworzenie kopca
		MoveDown(Tab, i, n-1);
printf("\nTablica przeksztalcona w kopiec\n");
printf("[ ");
for (i=0; i<n; i++) 
    printf(" %d", Tab[i]);
printf(" ]");
getche();
}

void MoveDown(int T[ ], int first, int last) {
int tmp, largest = 2*first+1;
  while (largest <= last)  {
	if (largest < last && T[largest] < T[largest+1] )
		largest ++ ;   /* first ma dwa nast�pniki: lewy  w 2*first+1 oraz prawy 
        		         w 2*first+2, przy czym prawy jest wi�kszy od lewego  */ 
	if (T[first] < T[largest]) {
	//  je�li trzeba zamie� wi�kszy nast�pnik z jego poprzednikiem 
    	tmp=T[first];
        T[first]=T[largest];
        T[largest]=tmp;
        first=largest;
		largest=2*first+1;
	}
	else largest=last+1; // nast�pi wyj�cie z p�tli; poddrzewo jest kopcem
  }
}

