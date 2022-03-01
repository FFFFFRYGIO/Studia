#include<iostream>
#include<cstdlib>
#include<ctime>

using namespace std;

int number = 10;

typedef struct Node{
    int min;
    int max;
    int bf;
    int val;
    struct Node *l;
    struct Node *r;
}Node;

void menu();
Node *constructNode(int min, int max);
void insertAVL(Node **t, Node *n);
int bfAVL(Node *n);
int height(Node *n);
void RRrotation(Node **t);
void LLrotation(Node **t);
void LRrotation(Node **t);
void RLrotation(Node **t);
int maxHigh(Node *n);
void printAVL(Node *t, int op);
void inorder(Node *t);
void preorder(Node *t);
void postorder(Node *t);
void levelorder(Node *t, int level);
void levelorder(Node *t);
Node *findAVL(Node *t, int x);
bool thisLvl(Node *t, int level, Node *n);
void printLevel(Node *t, int level, Node *n);
int findLvl(Node *t, Node *n);
Node *findNode(Node *t, int x);
Node *interAVL(Node *t, Node *n);
Node *findNodeX(Node *t, int x);
Node *max_successor(Node *t);
Node *remAVL(Node *t, Node *n);
void remAll(Node *t);

int main() {
    Node *t=NULL;
    Node *n;
    int action = -1, min, max, num;
    cout << "GENERATING TREE" << endl;
    for(int i=0; i<number; i++){
        min = rand()%150 + 1;
        max = min + rand()%50 + 1;
        n=constructNode(min, max);
        insertAVL(&t, n);
        cout << "E" << i+1 << "\t min: " << min << " \tmax:" << max << endl;
    }
    cout << "GENERATED TREE:" << endl;
    printAVL(t, 4);
    while(action)
    {
        menu();
        cout << "\tEnter action: ";
        cin >> action;
        switch (action)
        {
        case 1:
            system("cls");
            cout << "INSERTING ELEMENT" << endl;
            cout << "Input minimum value of interval: ";
            cin >> min;
            cout << "Input maximum value of interval: ";
            cin >> max;
            n=constructNode(min, max);
            insertAVL(&t, n);
            cout << "New tree:" << endl;
            printAVL(t, 4);
            cout << endl;
            break;
        case 2:
            system("cls");
            printAVL(t, 1);
            cout << endl;
            break;
        case 3:
            system("cls");
            printAVL(t, 2);
            cout << endl;
            break;
        case 4:
            system("cls");
            printAVL(t, 3);
            cout << endl;
            break;
        case 5:
            system("cls");
            printAVL(t, 4);
            cout << endl;
            break;
        case 6:
            system("cls");
            cout << "CHECKING CONDITION" << endl;
            cout << "Input number to check: ";
            cin >> num;
            n = findAVL(t, num);
            if(n == NULL)
                cout << "Numbers is not included in any set";
            else{
                cout << "Element found!" << endl;
                printf("Element: %d/%d,%d,%d\n",n->min, n->max, n->val, n->bf);
                cout << "All siglings:" << endl;
                printLevel(t, findLvl(t, n), n);
            }
            cout << endl;
            break;
        case 7:
            system("cls");
            cout << "CHECKING CONDITION" << endl;
            cout << "Input left extreme for specific element: ";
            cin >> num;
            if(findNode(t,num)==NULL)
                cout << "Wrong number" << endl;
            else{
                n = interAVL(t, findNodeX(t,num) );
                if(n == NULL)
                    cout << "No sets overlap this set" << endl;
                else{
                    printf("Set found: %d/%d\n", n->min, n->max);
                }
            }
            cout << endl;
            break;
        case 8:
            system("cls");
            cout << "REMOVING ELEMENT FROM TREE" << endl;
            cout << "Input left extreme for specific element: ";
            cin >> num;
            if(findNode(t,num)==NULL)
                cout << "Wrong number" << endl;
            else{
                cout << "Before removing:" << endl;
                printAVL(t, 4);
                t=remAVL(t, n);
                cout << "After removing:" << endl;
                printAVL(t, 4);
            }
            break;
        case 9:
            system("cls");
            cout << "REMOVING TREE" << endl;
            remAll(t);
            cout << "END OF PROGRAM" << endl;
            return 0;
            break;
        default:
            system("cls");
            cout << "Wrong action, please enter correct number" << endl;
            break;
        }
    }
    return 0;
}

void menu(){
    cout << endl << "Possible actions::" << endl;
    cout << "1. Insert an element into tree" << endl;
    cout << "2. Print tree LVR (inorder)" << endl;
    cout << "3. Print tree VLR (preorder)" << endl;
    cout << "4. Print tree LRV (postorder)" << endl;
    cout << "5. Print tree level order" << endl;
    cout << "6. Check if the number is included in any set" << endl;
    cout << "7. Check if the set go under another set" << endl;
    cout << "8. Remove scepific element from tree" << endl;
    cout << "9. Remove whole tree and end program" << endl;
}

Node *constructNode(int min, int max){
    Node *n = (Node*) malloc(sizeof(Node));
    n->min=min;
    n->max=max;
    n->val=0;
    n->bf=0;
    n->l=NULL;
    n->r=NULL;
    return n;
}

void insertAVL(Node **t, Node *n){
    if((*t)==NULL){
        *t=n;
        return;
    }
    n->val=n->max;
    if(n->min < (*t)->min)
        insertAVL(&((*t)->l), n);
    else
        insertAVL(&((*t)->r), n);

    (*t)->bf= bfAVL(*t);

    if ((*t)->bf>1 && n->min<(*t)->l->min) {
        LLrotation(t);
    } else if ((*t)->bf>1 && n->min>(*t)->l->min) {
        LRrotation(t);
    } else if ((*t)->bf< -1 && n->min>(*t)->r->min) {
        RRrotation(t);
    } else if ((*t)->bf< -1 && n->min<(*t)->r->min) {
        RLrotation(t);
    }

    (*t)->val=maxHigh(*t);
}

int bfAVL(Node *n){
    if(n==NULL) return 0;
    return height(n->l)-height(n->r);
}

int height(Node *n){
    if(n==NULL){
        return 0;
    }else{
        int l= height(n->l);
        int r= height(n->r);
        if(l<r) return r+1;
        else return l+1;
    }
}

void RRrotation(Node **t){
    Node *s=(*t)->r->l;
    (*t)->r->l=*t;
    *t=(*t)->r;
    (*t)->l->r=s;

    (*t)->l->bf= bfAVL((*t)->l);
    (*t)->bf= bfAVL(*t);
}

void LLrotation(Node **t){
    Node *s=(*t)->l->r;
    (*t)->l->r=*t;
    *t=(*t)->l;
    (*t)->r->l=s;

    (*t)->r->bf= bfAVL((*t)->r);
    (*t)->bf= bfAVL(*t);
}

void LRrotation(Node **t){
    Node *sr=(*t)->l->r->r;
    (*t)->l->r->r=*t;
    Node *sl=(*t)->l->r->l;
    (*t)->l->r->l=(*t)->l;
    *t=(*t)->l->r;
    (*t)->r->l=sr;
    (*t)->l->r=sl;

    (*t)->l->bf= bfAVL((*t)->l);
    (*t)->r->bf= bfAVL((*t)->r);
    (*t)->bf= bfAVL(*t);
}

void RLrotation(Node **t){
    Node *sl=(*t)->r->l->l;
    (*t)->r->l->l=*t;
    Node *sr=(*t)->r->l->r;
    (*t)->r->l->r=(*t)->r;
    *t=(*t)->r->l;
    (*t)->l->r=sl;
    (*t)->r->l=sr;

    (*t)->l->bf= bfAVL((*t)->l);
    (*t)->r->bf= bfAVL((*t)->r);
    (*t)->bf= bfAVL(*t);
}

int maxHigh(Node *n) {
    if (n == NULL) {
        return 0;
    }else if(n->l==NULL && n->r==NULL){
        return n->max;
    }else{
        int l=maxHigh(n->l);
        int r=maxHigh(n->r);
        if(l<r) return r;
        else return l;
    }
}

void printAVL(Node *t, int op){
    if(op==1){
        cout<<"Printing tree LVR (inorder)" << endl;
        inorder(t);
    }else if(op==2){
        cout<<"Printing tree VLR (preorder)" << endl;
        preorder(t);
    }else if(op==3){
        cout<<"Printing tree LRV (postorder)" << endl;
        postorder(t);
    }else if(op==4){
        cout<<"Printing tree level order" << endl;
        levelorder(t);
    }
    else{
        cout << "Wrong number!" << endl;
    }
    cout<<endl;
}

void inorder(Node *t){
    if(t==NULL){
        return;
    }
    if(t->l != NULL) inorder(t->l);
    printf("%d/%d,%d,%d -> ", t->min, t->max, t->val, t->bf);
    if(t->r != NULL) inorder(t->r);
}

void preorder(Node *t){
    if(t==NULL){
        return;
    }
    printf("%d/%d,%d,%d -> ", t->min, t->max, t->val, t->bf);
    if(t->l != NULL) preorder(t->l);
    if(t->r != NULL) preorder(t->r);
}

void postorder(Node *t){
    if(t==NULL){
        return;
    }
    if(t->l != NULL) postorder(t->l);
    if(t->r != NULL) postorder(t->r);
    printf("%d/%d,%d,%d -> ", t->min, t->max, t->val, t->bf);
}

void levelorder(Node *t, int level){
    if(t==NULL) return;
    if(level==1)
        printf("%d/%d,%d,%d -> ", t->min, t->max, t->val, t->bf);
    else if(level>1){
        levelorder(t->l, level-1);
        levelorder(t->r, level-1);
    }
}

void levelorder(Node *t){
    for(int i=0; i< height(t)+1; i++)
        levelorder(t,i);
}

Node *findAVL(Node *t, int x){
    if(t==NULL || (t->min<=x && x<=t->max))
        return t;
    else
        if(x < t->min)
            return findAVL(t->l, x);
    return findAVL(t->r, x);
}

bool thisLvl(Node *t, int level, Node *n){
    if(t==NULL) return false;
    if(level==1){
        if(t==n)
            return true;
        else
            return false;
    }
    else{
        if(level>1){
            if(thisLvl(t->l, level-1, n) || thisLvl(t->r, level-1, n))
                return true;
            else
                return false;
        }
        else
            return false;
    }  
}

void printLevel(Node *t, int level, Node *n){
    if(t==NULL) return;
    if(level==1){
        if(t!=n) printf("%d/%d,%d,%d, ",t->min, t->max, t->val, t->bf);
    }
    else if(level>1){
        printLevel(t->l, level-1, n);
        printLevel(t->r, level-1, n);
    }
}

int findLvl(Node *t, Node *n){
    for(int i=1; i< height(t)+1; i++){
        if(thisLvl(t,i,n)) return i;
    }
    return 0;
}

Node *findNode(Node *t, int x){
    if(t==NULL) return NULL;
    else if(t->min==x)
        return t;
    else if(x<t->min)
        return findNode(t->l, x);
    return findNode(t->r, x);
}

Node *interAVL(Node *t, Node *n){
    if(t==NULL)
        return NULL;
    if(t->max < n->min)
        return interAVL(t->r, n);
    else{
        if(n->max < t->min)
            return interAVL(t->l, n);
        else{
            if(t!=n)
                return t;
            else{
                Node *x=interAVL(t->r, n);
                Node *y=interAVL(t->l, n);
                if(x!=NULL)
                    return x;
                else
                    return y;
            }
        }
    }
}

Node *findNodeX(Node *t, int x){
    if(t==NULL) return NULL;
    else if(t->min==x)
        return t;
    else if(x<t->min)
        return findNodeX(t->l, x);
    return findNodeX(t->r, x);
}

Node *max_successor(Node *t){
    if(t->l!=NULL) return max_successor(t->l);
    else return t;
}

Node *remAVL(Node *t, Node *n){
    if(t==NULL){
        return t;
    }
    if(n->min < t->min) t->l = remAVL(t->l, n);
    else if(n->min > t->min) t->r = remAVL(t->r, n);
    else {
        if(t->l==NULL){
            Node *x=t->r;
            free(t);
            return x;
        }else if(t->r==NULL){
            Node *x=t->l;
            free(t);
            return x;
        }
        Node *x=max_successor(t->r);
        t->min=x->min;
        t->max=x->max;

        t->r= remAVL(t->r, x);
    }

    t->bf= bfAVL(t);

    if (t->bf>1 && bfAVL(t->l) >= 0) {
        LLrotation(&t);
    } else if (t->bf>1 && bfAVL(t->l) < 0) {
        LRrotation(&t);
    } else if (t->bf< -1 && bfAVL(t->r) <= 0) {
        RRrotation(&t);
    } else if (t->bf< -1 && bfAVL(t->r) > 0) {
        RLrotation(&t);
    }

    t->val=maxHigh(t);

    return t;
}

void remAll(Node *t){
    if(t==NULL){
        return;
    }
    remAll(t->l);
    remAll(t->r);
    free(t);
}