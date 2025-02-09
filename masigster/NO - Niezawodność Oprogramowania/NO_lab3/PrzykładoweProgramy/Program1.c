#include <stdio.h>
int main(void) {
	int n,k,p,Liczba;
 
   k=2;
   n=0;
   p=0;
   printf("Program sprawdza czy podana  liczba jest liczba pierwsza.");
   printf("\nPodaj jakas liczbe: ");
   scanf("%i",&n);
   printf("Podana liczba to %i. ",n);
   if(n<=2) printf("NIE jest to liczba pierwsza.");
   else
   {
     while(k*k<=n){
      if (n % k==0) {p = 0; k = n;}
      else {k=k+1; p=1;}
     };
   };
   if (p==1) printf("To jest liczba pierwsza.");
   else printf("To NIE jest liczba pierwsza.");
   getchar();
   getchar();
   
   do {
	   printf("\nWprowadz liczbe od 1 do 4 (0 konczy): ");
	   scanf("%d", &Liczba);
	   switch(Liczba) {
		case 1: printf("jeden");
			break;
		case 2: printf("dwa");
			break;
		case 3: printf("trzy");
			break;
		case 4: printf("cztery");
			break;
		default: printf("Liczba nierozpoznana");
	    }
	} while(Liczba);
    return 0;
}			
