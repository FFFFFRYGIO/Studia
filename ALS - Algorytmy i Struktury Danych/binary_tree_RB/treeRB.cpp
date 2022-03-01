#include <iostream>
#include <string>
#include <cstdlib>
#include <ctime>

using namespace std;
int n = 10, keys_sort[20], x = 0;

struct RBTNode
{
  RBTNode *up = NULL;
  RBTNode *l = NULL;
  RBTNode *r = NULL;
  float key;
  char color;
};

class TRBTree
{
private:
  RBTNode S;
  string cr, cl, cp;
  void printRBT(string sp, string sn, RBTNode *p);

public:
  RBTNode *root;

  TRBTree();
  ~TRBTree();
  void DFSRelease(RBTNode *p);
  void print();
  RBTNode *findRBT(float k);
  RBTNode *minRBT(RBTNode *p);
  RBTNode *succRBT(RBTNode *p);
  void rot_L(RBTNode *A);
  void rot_R(RBTNode *A);
  void insertRBT(float k);
  void removeRBT(RBTNode *X);

  void copyRB(TRBTree *t);
  void copyRBT(TRBTree *T, RBTNode *t);
  void removeRB(struct RBTNode *t);

  void printRB(int op);
  void inorder(struct RBTNode *t);
  void preorder(struct RBTNode *t);
  void postorder(struct RBTNode *t);
};

TRBTree::TRBTree()
{
  cr = cl = cp = "  ";
  cr[0] = 218;
  cr[1] = 196;
  cl[0] = 192;
  cl[1] = 196;
  cp[0] = 179;
  S.color = 'B';
  S.up = &S;
  S.l = &S;
  S.r = &S;
  root = &S;
}

TRBTree::~TRBTree()
{
  DFSRelease(root);
}

void TRBTree::DFSRelease(RBTNode *p)
{
  if (p != &S)
  {
    DFSRelease(p->l);
    DFSRelease(p->r);
    delete p;
  }
}

void TRBTree::printRBT(string sp, string sn, RBTNode *p)
{
  string t;

  if (p != &S)
  {
    t = sp;
    if (sn == cr)
      t[t.length() - 2] = ' ';
    printRBT(t + cp, cr, p->r);

    t = t.substr(0, sp.length() - 2);
    cout << t << sn << p->color << ":" << p->key << endl;

    t = sp;
    if (sn == cl)
      t[t.length() - 2] = ' ';
    printRBT(t + cp, cl, p->l);
  }
}

void TRBTree::print()
{
  printRBT("", "", root);
}

RBTNode *TRBTree::findRBT(float k)
{
  RBTNode *p;

  p = root;
  while ((p != &S) && (p->key != k))
    if (k < p->key)
      p = p->l;
    else
      p = p->r;
  if (p == &S)
    return NULL;
  return p;
}

RBTNode *TRBTree::minRBT(RBTNode *p)
{
  if (p != &S)
    while (p->l != &S)
      p = p->l;
  return p;
}

RBTNode *TRBTree::succRBT(RBTNode *p)
{
  RBTNode *r;

  if (p != &S)
  {
    if (p->r != &S)
      return minRBT(p->r);
    else
    {
      r = p->up;
      while ((r != &S) && (p == r->r))
      {
        p = r;
        r = r->up;
      }
      return r;
    }
  }
  return &S;
}

void TRBTree::rot_L(RBTNode *A)
{
  RBTNode *B, *p;

  B = A->r;
  if (B != &S)
  {
    p = A->up;
    A->r = B->l;
    if (A->r != &S)
      A->r->up = A;

    B->l = A;
    B->up = p;
    A->up = B;

    if (p != &S)
    {
      if (p->l == A)
        p->l = B;
      else
        p->r = B;
    }
    else
      root = B;
  }
}

void TRBTree::rot_R(RBTNode *A)
{
  RBTNode *B, *p;

  B = A->l;
  if (B != &S)
  {
    p = A->up;
    A->l = B->r;
    if (A->l != &S)
      A->l->up = A;

    B->r = A;
    B->up = p;
    A->up = B;

    if (p != &S)
    {
      if (p->l == A)
        p->l = B;
      else
        p->r = B;
    }
    else
      root = B;
  }
}

void TRBTree::insertRBT(float k)
{
  RBTNode *X, *Y;

  X = new RBTNode;
  X->l = &S;
  X->r = &S;
  X->up = root;
  X->key = k;
  if (X->up == &S)
    root = X;
  else
    while (true)
    {
      if (k < X->up->key)
      {
        if (X->up->l == &S)
        {
          X->up->l = X;
          break;
        }
        X->up = X->up->l;
      }
      else
      {
        if (X->up->r == &S)
        {
          X->up->r = X;
          break;
        }
        X->up = X->up->r;
      }
    }
  X->color = 'R';
  while ((X != root) && (X->up->color == 'R'))
  {
    if (X->up == X->up->up->l)
    {
      Y = X->up->up->r;

      if (Y->color == 'R')
      {
        X->up->color = 'B';
        Y->color = 'B';
        X->up->up->color = 'R';
        X = X->up->up;
        continue;
      }

      if (X == X->up->r)
      {
        X = X->up;
        rot_L(X);
      }

      X->up->color = 'B';
      X->up->up->color = 'R';
      rot_R(X->up->up);
      break;
    }
    else
    {
      Y = X->up->up->l;

      if (Y->color == 'R')
      {
        X->up->color = 'B';
        Y->color = 'B';
        X->up->up->color = 'R';
        X = X->up->up;
        continue;
      }

      if (X == X->up->l)
      {
        X = X->up;
        rot_R(X);
      }

      X->up->color = 'B';
      X->up->up->color = 'R';
      rot_L(X->up->up);
      break;
    }
  }
  root->color = 'B';
}

void TRBTree::removeRBT(RBTNode *X)
{
  RBTNode *W, *Y, *Z;

  if ((X->l == &S) || (X->r == &S))
    Y = X;
  else
    Y = succRBT(X);

  if (Y->l != &S)
    Z = Y->l;
  else
    Z = Y->r;

  Z->up = Y->up;

  if (Y->up == &S)
    root = Z;
  else if (Y == Y->up->l)
    Y->up->l = Z;
  else
    Y->up->r = Z;

  if (Y != X)
    X->key = Y->key;

  if (Y->color == 'B')
    while ((Z != root) && (Z->color == 'B'))
      if (Z == Z->up->l)
      {
        W = Z->up->r;

        if (W->color == 'R')
        {
          W->color = 'B';
          Z->up->color = 'R';
          rot_L(Z->up);
          W = Z->up->r;
        }

        if ((W->l->color == 'B') && (W->r->color == 'B'))
        {
          W->color = 'R';
          Z = Z->up;
          continue;
        }

        if (W->r->color == 'B')
        {
          W->l->color = 'B';
          W->color = 'R';
          rot_R(W);
          W = Z->up->r;
        }

        W->color = Z->up->color;
        Z->up->color = 'B';
        W->r->color = 'B';
        rot_L(Z->up);
        Z = root;
      }
      else
      {
        W = Z->up->l;

        if (W->color == 'R')
        {
          W->color = 'B';
          Z->up->color = 'R';
          rot_R(Z->up);
          W = Z->up->l;
        }

        if ((W->l->color == 'B') && (W->r->color == 'B'))
        {
          W->color = 'R';
          Z = Z->up;
          continue;
        }

        if (W->l->color == 'B')
        {
          W->r->color = 'B';
          W->color = 'R';
          rot_L(W);
          W = Z->up->l;
        }

        W->color = Z->up->color;
        Z->up->color = 'B';
        W->l->color = 'B';
        rot_R(Z->up);
        Z = root;
      }

  Z->color = 'B';

  delete Y;
}

void TRBTree::inorder(struct RBTNode *t)
{
  if (t->l != &S)
    inorder(t->l);
  cout << t->key << " -> ";
  if (t->r != &S)
    inorder(t->r);
}

void TRBTree::preorder(struct RBTNode *t)
{
  cout << t->key << " -> ";
  if (t->l != &S)
    preorder(t->l);
  if (t->r != &S)
    preorder(t->r);
}

void TRBTree::postorder(struct RBTNode *t)
{
  if (t->l != &S)
    postorder(t->l);
  if (t->r != &S)
    postorder(t->r);
  cout << t->key << " -> ";
}

void TRBTree::printRB(int op)
{
  if (root == &S)
  {
    printf("Drzewo puste\n");
    return;
  }

  switch (op)
  {
  case 1:
    cout << "Kolejnosc inorder: " << endl;
    inorder(root);
    break;
  case 2:
    cout << "Kolejnosc preorder" << endl;
    preorder(root);
    break;
  case 3:
    cout << "kolejnosc postorder" << endl;
    postorder(root);
    break;
  default:
    printf("Zla liczba!");
    break;
  }
}

void TRBTree::copyRB(TRBTree *t)
{
  copyRBT(t, t->root);
}

void TRBTree::copyRBT(TRBTree *T, RBTNode *t)
{
  if (t->l != &(T->S))
  {
    copyRBT(T, t->l);
  }
  insertRBT(t->key);
  if (t->r != &(T->S))
  {
    copyRBT(T, t->r);
  }
}

void TRBTree::removeRB(struct RBTNode *t)
{
  if (t->l != &S)
    removeRB(t->l);
  keys_sort[x++] = t->key;
  print();
  if (t->r != &S)
    removeRB(t->r);
}

int program()
{
  srand(time(NULL));
  int n = 10, k[n], ks[n], n_max = 200;
  float p[n], ps[n];
  TRBTree *T1, *T2, *T3;
  T1 = new TRBTree;
  T2 = new TRBTree;
  T3 = new TRBTree;

  cout << "Losowanie kluczy" << endl
       << endl;
  for (int i = 0; i < n; i++)
  {
    k[i] = 1 + rand() % n_max;
    ks[i] = k[i];
    p[i] = rand() % 100 / 100.0;
    ps[i] = p[i];
  }

  cout << "Wylosowane klucze:" << endl;
  for (int i = 0; i < n; i++)
  {
    cout << k[i] << " ";
  }
  cout << endl
       << endl;

  cout << "Wylosowane priorytety:" << endl;
  for (int i = 0; i < n; i++)
  {
    cout << p[i] << " ";
  }
  cout << endl
       << endl;

  cout << "Tworzenie drzewa T1 na podstawie kluczy" << endl;
  for (int i = 0; i < n; i++)
  {
    // cout << k[i] << " ";
    T1->insertRBT(k[i]);
  }
  cout << "Utworzone drzewo T1:" << endl;
  T1->print();
  T1->printRB(1);
  cout << endl;
  T1->printRB(2);
  cout << endl;
  T1->printRB(3);
  cout << endl
       << endl;

  cout << "Kopiowanie drzewa T1 do drzewa T2" << endl;
  T2->copyRB(T1);
  cout << "Utworzonne drzewo T2:" << endl;
  T2->print();
  cout << endl;

  cout << "Tworzenie drzewa T3 na podstawie priorytetow" << endl;
  for (int i = 0; i < n; i++)
  {
    // cout << p[i] << " ";
    T3->insertRBT(p[i]);
  }
  cout << "Utworzone drzewo T3:" << endl;
  T3->print();
  T3->printRB(1);
  cout << endl;
  T3->printRB(2);
  cout << endl;
  T3->printRB(3);
  cout << endl
       << endl;

  cout << endl
       << "Usuwanie drzewa T1: " << endl;
  for (int i = 0; i < n; i++)
  {
    cout << endl
         << "Usuwanie elementu " << ks[i] << endl;
    T1->removeRBT(T1->findRBT(ks[i]));
    T1->print();
    if (i == n - 1)
      cout << "puste drzewo" << endl;
  }
  cout << endl;

  cout << endl
       << "Usuwanie drzewa T3: " << endl;
  for (int i = 0; i < n; i++)
  {
    cout << endl
         << "Usuwanie elementu " << ps[i] << endl;
    T3->removeRBT(T3->findRBT(ps[i]));
    T3->print();
    if (i == n - 1)
      cout << "puste drzewo" << endl;
  }
  cout << endl;

  cout << "Stan drzewa T2 po usunieciu drzewa T1:" << endl;
  T2->print();

  delete T1;
  delete T2;
  delete T3;

  return 0;
}

void menu()
{
  printf("\nPossible actions:\n");
  printf("1. Insert an element into tree\n");
  printf("2. Print tree LVR (inorder)\n");
  printf("3. Print tree VLR (preorder)\n");
  printf("4. Print tree LRV (postorder)\n");
  printf("5. Print tree (structure representation)\n");
  printf("6. Remove specific element from tree\n");
  printf("7. Copy tree\n");
  printf("8. Remove tree ascending\n");
  printf("9. Remove tree descending\n");
  printf("0. End program\n");
}

int main()
{
  srand(time(NULL));
  int k[n], ks[n], n_max = 200;
  float p[n], ps[n];
  TRBTree *T1, *T2, *T3;
  T1 = new TRBTree;
  T2 = new TRBTree;
  T3 = new TRBTree;
  x = 0;
  for(int i=0;i<20;i++){
    keys_sort[i] = 0;
  }

  cout << "Drawing keys and priorities" << endl
       << endl;
  for (int i = 0; i < n; i++)
  {
    k[i] = 1 + rand() % n_max;
    ks[i] = k[i];
    p[i] = rand() % 100 / 100.0;
    ps[i] = p[i];
  }

  cout << "Drawn keys:" << endl;
  for (int i = 0; i < n; i++)
  {
    cout << k[i] << " ";
  }
  cout << endl
       << endl;

  cout << "Drawn priorities:" << endl;
  for (int i = 0; i < n; i++)
  {
    cout << p[i] << " ";
  }
  cout << endl
       << endl;

  cout << "Creating T1 tree basen on keys" << endl;
  for (int i = 0; i < n; i++)
  {
    // cout << k[i] << " ";
    T1->insertRBT(k[i]);
  }
  cout << "Created T1 tree:" << endl;
  T1->print();
  T1->printRB(1);
  cout << endl;
  T1->printRB(2);
  cout << endl;
  T1->printRB(3);
  cout << endl
       << endl;

  cout << "Copying tree T1 to tree T2" << endl;
  // T2->copyRB(T1);
  cout << "Created T2 tree:" << endl;
  T2->print();
  cout << endl;

  cout << "Creating T3 tree basen on priorities" << endl;
  for (int i = 0; i < n; i++)
  {
    // cout << p[i] << " ";
    T3->insertRBT(p[i]);
  }
  cout << "Created T3 tree:" << endl;
  T3->print();
  T3->printRB(1);
  cout << endl;
  T3->printRB(2);
  cout << endl;
  T3->printRB(3);
  cout << endl
       << endl;

  // FAKTYCZNY PROGRAM
  TRBTree *currentT;
  currentT = T1;
  int action = 10, key = 0;
  while (action)
  {
    menu();
    printf("\nChoose action: ");
    scanf("%d", &action);
    switch (action)
    {
    case 1:
      system("cls");
      printf("Enter element to add to tree: ");
      scanf("%d", &key);
      printf("Tree before insertion:\n");
      currentT->print();
      printf("\n");
      currentT->insertRBT(key);
      printf("Tree after insertion:\n");
      currentT->print();
      printf("\n");
      break;
    case 2:
      system("cls");
      currentT->printRB(1);
      printf("\n");
      break;
    case 3:
      system("cls");
      currentT->printRB(2);
      printf("\n");
      break;
    case 4:
      system("cls");
      currentT->printRB(3);
      printf("\n");
      break;
    case 5:
      system("cls");
      cout << "Printing graphic representation of tree" << endl;
      currentT->print();
      printf("\n");
      break;
    case 6:
      system("cls");
      printf("Enter element to remove from tree: ");
      scanf("%d", &key);
      printf("Tree before removing:\n");
      currentT->print();
      printf("\n");
      currentT->removeRBT(currentT->findRBT(key));
      printf("Tree after removing:\n");
      currentT->print();
      printf("\n");
      break;
    case 7:
      system("cls");
      cout << "Copying tree" << endl;
      T2->copyRB(T1);
      cout << "Tree copyed\nCopyed tree:" << endl;
      T2->print();
      printf("\n");
      break;
    case 8:
      system("cls");
      cout << "Removing whole tree ascending" << endl;
      currentT->removeRB(currentT->root);
      for(int i=0; i<20 && keys_sort[i] != 0;i++){
        cout << endl << "Removing element " << keys_sort[i] << endl;
        currentT->removeRBT(currentT->findRBT(keys_sort[i]));
        currentT->print();
        if(keys_sort[i+1] == 0)
          cout << "Tree empty" << endl;
      }
      printf("\n");
      break;
    case 9:
      system("cls");
      cout << "Removing whole tree descending" << endl;
      currentT->removeRB(currentT->root);
      for(int i=19 ; i >= 0 ; i--){
        if(keys_sort[i] != 0){
          cout << endl << "Removing element " << keys_sort[i] << endl;
          currentT->removeRBT(currentT->findRBT(keys_sort[i]));
          currentT->print();
          if(i == 0)
            cout << "Tree empty" << endl;
        }
      }
      printf("\n");
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