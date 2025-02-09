#include<stdio.h>
#include<stdlib.h>
 
int main(){
   int n,k,p;
   k=2;
   n=0;
   p=0;
   printf("Program sprawdza czy podana przez Ciebie liczba jest liczba pierwsza.");
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
   return 0;
};
