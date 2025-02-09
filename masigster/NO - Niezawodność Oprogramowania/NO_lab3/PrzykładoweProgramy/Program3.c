
#include <stdio.h>
#include <conio.h>

int find_substr(char *s1, char *s2);

int main(void){
  if(find_substr("Jezyk C jest bardzo efektywny", "bardzo") != -1)
    printf("Znaleziono podnapis w napisie");

  getche();
  return 0;
}

/* Zwróæ indeks pierwszego wyst¹pienia s2 w s1. */
int find_substr(char *s1, char *s2)
{
  int t;
  char *p1, *p2;

  for(t=0; s1[t]; t++) {
    p1 = &s1[t];
    p2 = s2;
    while(*p2 && *p2==*p1) {
      p1++;
      p2++;
    }
    return t; /* Pierwsza instrukcja return */
  }
  printf("Nie zanaleziono podnapisu w napisie");
  return -1;          /* Druga instrukcja return */
}
