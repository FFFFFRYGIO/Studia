/* Ten program tworzy i wyœwietla drzewo typu BST */

#include <stdlib.h>
#include <stdio.h>


#define TRUE 1
#define FALSE 0

typedef int BOOLEAN;
typedef char ETYPE;

typedef struct NODE *TREE;
struct NODE {
	ETYPE element;
	TREE left, right;
} *root;

/* funkcja print_tree(T,l) drukuje drzewo T poczynaj¹c od korzenia */
void print_tree(TREE T, int l);

/* funkcja insert (x, T) dodaje wartosc x do drzewa T */
TREE insert(ETYPE x, TREE T);


int main(void)
{
  char s[80];
  root = NULL;  /* inicjacja korzenia */
  do {
    printf("Wpisz litere i nacisnij Enter (sam Enter konczy tworzenie drzewa): ");
    gets(s);
    if(*s!='\0')root = insert(*s, root);
  } while(*s);
  printf("\n\nWyswietlanie drzewa z lewa na prawo (zamiast z gory w dol)");
  printf("\n\n");
  print_tree(root, 0);
  printf("\n\n");
  printf("Nacisnij Enter aby zakonczyc program");
  gets(s);
  return 0;
}

TREE insert(ETYPE x, TREE T)
{
	if (T == NULL) {
		T = (TREE) malloc(sizeof(struct NODE));
		T->element = x;
		T->left = NULL;
		T->right = NULL;
	}
	else if (x < T->element)
		T->left = insert(x, T->left);
	else if (x > T->element)
		T->right = insert(x, T->right);
	return T;
}


void print_tree(TREE T, int l)
{
  int i;
  if(!T) return;
  print_tree(T->right, l+1);
  for(i=0; i<l; ++i) printf("   ");
  printf("%c\n", T->element);
  print_tree(T->left, l+1);
}
