#include <iostream>
#include <ctime>
#include <conio.h>
using namespace std;

const int L=4;
int n;

typedef struct Elem{
    int x;
    int key;
}Elem;

typedef struct keys{
    int first, second;
}keys;

bool isEmpty(Elem* quel){
    for(int i=0;i<n;i++)
        if(quel[i].x!=0)
            return false;
    return true;
}

int sizeQuel(Elem* quel){
    int s=0;
    for(int i=0;i<n;i++)
        if(quel[i].x)
            s++;
    return s;
}

void addQuel(Elem* quel, int x, int key){
    if(isEmpty(quel)){
        quel[n-1].x=x;
        quel[n-1].key=key;
        return;
    }
    if(sizeQuel(quel)<n)
        for(int i=0; i<n; i++)
            if(quel[i].x!=0){
                quel[i-1].x=x;
                quel[i-1].key=key;
                return;
            }
}

void extractQuel(Elem* quel){
    if(isEmpty(quel)) return;
    for(int i=n-1;i>=1;i--){
        quel[i]=quel[i-1];
    }
    quel[0].key=0;
    quel[0].x=0;
}

Elem* maxQ(Elem* quel){
    int max=0;
    Elem* maxq;
    for(int i=0; i<n; i++)
        if(quel[i].key>max){
            max=quel[i].key;
            maxq=&quel[i];
        }
    return maxq;
}

void incKey(Elem* quel, int x, int k){
    for(int i=0;i<n;i++)
        if(quel[i].x==x){
            quel[i].key=k;
            return;
        }
}

void printQuel(Elem* quel){
    cout<<"\t";
    for(int i=0; i<n; i++)
        if(quel[i].key==0)
            cout<<"\t";
        else
            cout<<quel[i].x<<"("<<quel[i].key<<")\t";
}

void PrintAllQuels(Elem** quels){
    for(int i=0;i<L;i++){
        cout<<"----------------------------------------------------\n";
        cout<<"K"<<i+1<<":";
        printQuel(quels[i]);
        if(isEmpty(quels[i])) cout<<"EMPTY";
        if(sizeQuel(quels[i])>=n) cout<<"WAIT";
        cout<<endl;
    }
    cout<<"----------------------------------------------------\n";
}

int lowestSizeQuel(Elem** quels){
    int min= sizeQuel(quels[0]), minQ=0;
    for(int i=1; i<L; i++)
        if(sizeQuel(quels[i])<min){
            min=sizeQuel(quels[i]);
            minQ=i;
        }
    return minQ;
}

keys highestPriority(Elem** quels){
    keys key;
    key.first=0;
    key.second=0;
    int max=0;
    for(int i=0;i<L;i++)
        if(quels[i][n-1].key>max){
            max=quels[i][n-1].key;
            key.first=i;
        }
    max=0;
    for(int i=0; i<L; i++)
        if(quels[i][n-1].key>max && i!=key.first){
            max=quels[i][n-1].key;
            key.second=i;
        }
    return key;
}

int main(){
    srand(time(NULL));
    cout<<"Input quels length: ";
    cin>>n;
    Elem ** quels = new Elem *[L];
    for(int i=0; i<L; i++){
        quels[i]=new Elem[n];
        for(int j=0; j<n; j++){
            quels[i][j].x=0;
            quels[i][j].key=0;
        }
    }

    int init;
    init=rand()%(4*n)+1;
    int x, key;
    cout<<endl<<"Initializing quels for "<<init<<" elements"<<endl;

    while (init>0){
        for(int i=0; i<L && init>0; i++){
            x=rand()%100+1;
            key=rand()%n+1;
            addQuel(quels[i],x,key);
            init--;
        }
    }

    char action;
    do{
        PrintAllQuels(quels);
        cout<<"Quels:"<<endl;
        cout<<"1. Add 4 elements to quels"<<endl;
        cout<<"2. Take 2 elements from quels"<<endl;
        cout<<"3. Print highest key in quel"<<endl;
        cout<<"4. Change key value in element"<<endl;
        cout<<"\n\t";
        cin>>action;
        system("cls");
        if(action=='0'){
            PrintAllQuels(quels);
            cout<<"End of program";
        }
        else if(action=='1'){
            PrintAllQuels(quels);
            for(int i=0; i<L; i++){
                x=rand()%100+1;
                key=rand()%n+1;
                int lowestQuel=lowestSizeQuel(quels);
                if(sizeQuel(quels[lowestQuel])<n) addQuel(quels[lowestQuel], x, key);
            }
            cout<<endl<<"Inserting 4 random elements:"<<endl;
            PrintAllQuels(quels);
            cout<<endl<<"kontynuuj ...";
            getch();
            system("cls");
        }
        else if(action=='2'){
            PrintAllQuels(quels);
            keys keysP;
            keysP=highestPriority(quels);
            extractQuel(quels[keysP.first]);
            extractQuel(quels[keysP.second]);
            cout<<endl<<"Removing 2 elements from quels:"<<endl;
            PrintAllQuels(quels);
            cout<<endl<<"continue ...";
            getch();
            system("cls");
        }
        else if(action=='3'){
            PrintAllQuels(quels);
            cout<<endl<<"Input quel number: ";
            int quelN;
            cin>>quelN;
            cout<<"Highest key in "<<quelN<<" quel: ";
            cout<<maxQ(quels[quelN-1])->x<<"("<<maxQ(quels[quelN-1])->key<<")"<<endl;
            cout<<endl<<"continue ...";
            getch();
            system("cls");
        }
        else if(action=='4'){
            PrintAllQuels(quels);
            cout<<endl<<"Input quel number: ";
            int quelN;
            cin>>quelN;
            cout<<"Input key value to change: ";
            int newx;
            cin>>newx;
            incKey(quels[quelN-1],newx,rand()%n+1);
            cout<<endl<<"Changed key:"<<endl;
            PrintAllQuels(quels);
            cout<<endl<<"continue ...";
            getch();
            system("cls");
        }
        else
            cout<<"Error!"<<endl;
    }while(action!='0');

    return 0;
}
