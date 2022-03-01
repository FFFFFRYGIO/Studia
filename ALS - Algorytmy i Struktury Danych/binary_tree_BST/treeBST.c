#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

struct btnode
{
    int key;
    struct btnode *l;
    struct btnode *r;
}*root = NULL, *temp = NULL, *t2, *t1;

int n = 10;
int rangeMin = 1;
int rangeMax = 80;
int flag = 1;
int tab[20];
int nodeI=0;
int tabPrintPossible = 1;
int optimalHeight;

void menu();
void insertBST(struct btnode *t, int key);
void allocate(struct btnode *t);
void printBST(struct btnode *t, int op);
void inorder(struct btnode *t);
void preorder(struct btnode *t);
void postorder(struct btnode *t);
void levelorder(struct btnode *t);
int heightBST(struct btnode *t);
void printLevel(struct btnode *t, int lvl);
int countLevBST(struct btnode *t, int level, int current_lvl);
void h2BST(struct btnode *t);
int countBST(struct btnode *t);
void removeBST(struct btnode *t, int key);
void findnode(struct btnode *t, int key);
void delete(struct btnode *t);
int max_successor(struct btnode *t);
int max_predecessor(struct btnode *t);
void tableBST(struct btnode *t);
void printtable(struct btnode *t, int lvl);

int main()
{
    srand(time(NULL));
    int action = 10, i, key, level;
    for(i=0;i<n;i++)
    {
        key = rand()%(rangeMax - rangeMin) + rangeMin;
        insertBST(root, key);
    }
    printf("Tree input:\n");
    printBST(root, 4);
    printf("\n");

    while(action)
    {
        menu();
        printf("\nEnter action: ");
        scanf("%d", &action);
        switch (action)
        {
        case 1:
            system("cls");
            printf("Enter element to add to tree: ");
            scanf("%d", &key);
            printf("Tree before insertion:\n");
            printBST(root, 4);
            printf("\n");
            insertBST(root, key);
            printf("Tree after insertion:\n");
            printBST(root, 4);
            printf("\n");
            break;
        case 2:
            system("cls");
            printBST(root, 1);
            printf("\n");
            break;
        case 3:
            system("cls");
            printBST(root, 2);
            printf("\n");
            break;
        case 4:
            system("cls");
            printBST(root, 3);
            printf("\n");
            break;
        case 5:
            system("cls");
            printBST(root, 4);
            printf("\n");
            break;
        case 6:
            system("cls");
            printf("Input level: ");
            scanf("%d", &level);
            printf("Current tree:\n");
            printBST(root, 4);
            printf("\n");
            printf("Counting elements on level %d\n", level);
            int x = countLevBST(root, level, 1);
            printf("Found %d elements on level %d", x, level);
            break;
        case 7:
            system("cls");
            printf("Current tree:\n");
            printBST(root, 4);
            printf("\n");
            h2BST(root);
            break;
        case 8:
            system("cls");
            printf("Enter element to remove from tree: ");
            scanf("%d", &key);
            printf("Tree before removing:\n");
            printBST(root, 4);
            printf("\n");
            removeBST(root, key);
            printf("Tree after removing:\n");
            printBST(root, 4);
            printf("\n");
            break;
        case 9:
            system("cls");
            tableBST(root);
            break;
        case 0:
            system("cls");
            printf("End of program\n");
            break;
        default:
            system("cls");
            printf("Wrong action, Please enter correct number\\n");
            break;    
        }
    }
    return 0;
}

void menu()
{
    printf("\nPossible actions:\n");
    printf("1. Insert an element into tree\n");
    printf("2. Print tree LVR (inorder)\n");
    printf("3. Print tree VLR (preorder)\n");
    printf("4. Print tree LRV (postorder)\n");
    printf("5. Print tree level order\n");
    printf("6. Count elements on specific level\n");
    printf("7. Count max, min and optimal tree heightBST\n");
    printf("8. Remove specific element\n");
    printf("9. Print table representation of tree (if possible)\n");
    printf("0. End program\n");
}

void insertBST(struct btnode *t, int key)
{
    printf("Inserting element %d to tree\n", key);
    temp = (struct btnode *)malloc(1*sizeof(struct btnode));
    temp->key = key;
    temp->l = NULL;
    temp->r = NULL;
    if(root == NULL)
    {
        root = temp;
    }
    else
    {
        allocate(root);
    }  
}

void allocate(struct btnode *t)
{
    if ((temp->key >= t->key) && (t->r != NULL))
        allocate(t->r);
    else if ((temp->key >= t->key) && (t->r == NULL))
        t->r = temp;
    else if ((temp->key < t->key) && (t->l != NULL))
        allocate(t->l);
    else if ((temp->key < t->key) && (t->l == NULL))
        t->l = temp;
}

void printBST(struct btnode *t, int op)
{
    if (root == NULL)
    {
        printf("Tree empty\n");
        return;
    }

    switch (op)
    {
    case 1:
        printf("Printing tree LVR (inorder)\n");
        inorder(root);
        break;
    case 2:
        printf("Printing tree VLR (preorder)\n");
        preorder(root);
        break;
    case 3:
        printf("Printing tree LRV (postorder)\n");
        postorder(root);
        break;
    case 4:
        printf("Printing tree level order\n");
        levelorder(root);
        break;
    default:
        printf("Wrong number of operation!");
        break;
    }
}

void inorder(struct btnode *t)
{
    if (t->l != NULL)    
        inorder(t->l);
    printf("%d -> ", t->key);
    if (t->r != NULL)    
        inorder(t->r);
}

void preorder(struct btnode *t)
{
    printf("%d -> ", t->key);
    if (t->l != NULL)    
        preorder(t->l);
    if (t->r != NULL)    
        preorder(t->r);
}

void postorder(struct btnode *t)
{
    if (t->l != NULL) 
        postorder(t->l);
    if (t->r != NULL) 
        postorder(t->r);
    printf("%d -> ", t->key);
}

void levelorder(struct btnode *t)
{
    int i;
    for(i=0; i <= heightBST(t); i++)
    {
        printLevel(t, i);
    }
}

int heightBST(struct btnode *t)
{
    if (t == NULL)
        return 0;
    else {
        int lh = heightBST(t->l);
        int rh = heightBST(t->r);

        if (lh > rh)
            return (lh + 1);
        else
            return (rh + 1);
    }
}

void printLevel(struct btnode *t, int lvl)
{
    if (t == NULL)
        return;
    if (lvl == 1)
        printf("%d -> ", t->key);
    else if (lvl > 1)
    {
        printLevel(t->l, lvl-1);
        printLevel(t->r, lvl-1);
    }
}

int countLevBST(struct btnode *t, int lvl, int current_lvl)
{
    if(t == NULL)
        return 0;
    else
    {
        if(lvl == 1)
            return 1;
        else if(lvl > 1)
        {
            if(lvl == current_lvl)
                return 1;
            else
            {
                return countLevBST(t->l, lvl, current_lvl+1) + countLevBST(t->r, lvl, current_lvl+1);
            }
        }
    }
}

void h2BST(struct btnode *t)
{
    if (root == NULL)
    {
        printf("Tree empty\n");
        return;
    }
    printf("Calculating mix, max and optimal tree heightBST\n");
    int hgt=0, max=0, maxl=0, maxr=0, min=0, minl=0, minr=0;
    hgt = heightBST(t);
    printf("Current tree height is %d\n", hgt);
    max = countBST(t) - 1;
    printf("Maximum tree height is %d\n", max);
    if(max == 0)
        min = 0;
    else
        min = (int)ceil(log2(max + 1));
    printf("Minimum tree height is %d\n", min);
    maxl = countBST(t->l) - 1;
    printf("Maximum left branch height is %d\n", maxl);
    if(maxl == 0)
        minl = 0;
    else
        minl = (int)ceil(log2(maxl + 1));
    printf("Minimum left branch height is %d\n", minl);
    maxr = countBST(t->r) - 1;
    printf("Maximum right branch height is %d\n", maxr);
    if(maxr == 0)
        minr = 0;
    else
        minr = (int)ceil(log2(maxr + 1));
    printf("Minimum right branch height is %d\n", minr);
    optimalHeight = (int)ceil(log2(countBST(t)));
    printf("Optimal tree height is %d\n", optimalHeight);
}

int countBST(struct btnode *t)
{
    if(root == NULL)
        return 1;
    if(t == NULL)
    {
        return 0;
    }
    else
    {
        return 1 + countBST(t->l) + countBST(t->r);
    }
}

void removeBST(struct btnode *t, int key)
{
    if (root == NULL)
    {
        printf("Tree empty\n");
        return;
    }
    printf("Removing element %d from tree\n", key);
    t1 = root;
    t2 = root;
    findnode(root, key);
}

void findnode(struct btnode *t, int key)
{
    if ((key==t->key))
    {
        delete(t);
    }
    else if ((key > t->key))
    {
        t1 = t;
        findnode(t->r, key);
    }
    else if ((key < t->key))
    {
        t1 = t;
        findnode(t->l, key);
    }
}

void delete(struct btnode *t)
{
    int k;
    if (t->l == NULL && t->r == NULL) //No childs
    {
        if (t1->l == t)
        {
            t1->l = NULL;
        }
        else
        {
            t1->r = NULL;
        }
        t = NULL;
        free(t);
        return;
    }
    else if(t->r == NULL) //Letf child
    {
        if(t1 == t)
        {
            root = t->l;
            t1 = root;
        }
        else if(t1->l == t)
        {
            t1->l = t->l;
        }
        else
        {
            t1->r = t->l;
        }
        t = NULL;
        free(t);
        return;
    }
    else if (t->l == NULL) //Right child
    {
        if (t1 == t)
        {
            root = t->r;
            t1 = root;
        }
        else if (t1->r == t)
            t1->r = t->r;
        else
            t1->l = t->r;
        t == NULL;
        free(t);
        return;
    }
    else if ((t->l != NULL) && (t->r != NULL)) //Two childs
    {
        t2 = root;
        if (t->r != NULL)
        {
            k = max_predecessor(t->r);
            flag = 1;
        }
        else
        {
            k = max_successor(t->l);
            flag = 2;
        }
        findnode(root, k);
        t->key = k;
    }
}

int max_successor(struct btnode *t)
{
    if (t->r != NULL)
    {
        t2 = t;
        return(max_successor(t->r));
    }
    else    
        return(t->key);
}

int max_predecessor(struct btnode *t)
{
    t2 = t;
    if (t->l != NULL)
    {
        t2 = t;
        return(max_predecessor(t->l));
    }
    else    
        return (t->key);
}

void tableBST(struct btnode *t)
{
    if(root == NULL)
    {
        printf("Tree empty\n");
        return;
    }
    printf("Table representation of tree\n");
    optimalHeight = (int)ceil(log2(countBST(t)));
    printf("Current height: %d\nOprimal Height: %d\n", heightBST(t), optimalHeight);
    if(optimalHeight != heightBST(t))
    {
        printf("Wrong tree height\n");
        printf("Can't build table presentation of tree!\n");
        return;
    }
    int i;
    nodeI = 0;
    for(i=0;i<20;i++)
        tab[i] = 0;
    for(i=0; i <= heightBST(t); i++)
    {
        printtable(t, i);
    }
    int chanceOfError = 0;
    for(i=0;i<20;i++)
    {
        if(!chanceOfError)
        {
            if(tab[i] == 0)
                chanceOfError = 1;
        }
        else
        {
            if(tab[i] != 0)
            {
                tabPrintPossible = 0;
            }
        }
    }
    if(tabPrintPossible)
    {
        int cont = 1;
        for(i=0;i<20 && cont;i++)
        {
            printf("|");
            if(tab[i])
                printf(" %d |", tab[i]);
            else
                cont = 0;
        }
    }
    else
    {
        printf("Can't build table presentation of tree!");
    }
}

void printtable(struct btnode *t, int lvl)
{
    if (t == NULL)
        return;
    if (lvl == 1)
    {
        if(tab[nodeI] == t->key || tab[nodeI] == 0)
        {
            tab[nodeI] = t->key;
            if(t->l != NULL)
                tab[nodeI*2] = t->l->key;
            if(t->r != NULL)
                tab[nodeI*2+1] = t->r->key;
            nodeI++;
        }
        else
        {
            tabPrintPossible = 0;
        }
    }
    else if (lvl > 1)
    {
        if(t->l != NULL)
            printtable(t->l, lvl-1);
        if(t->r != NULL)
            printtable(t->r, lvl-1);
    }
}