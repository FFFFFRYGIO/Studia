#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<bits/stdc++.h>
#include<iostream>
#include<vector>
#include<string>
#include<fstream>

using namespace std;

#define MODEL_ARR_LEN 256

struct HuffmanNode {
public:
    unsigned char symbol = (char)0; // Faktyczny symbol
    bool is_symbol = false; // false dla wezlow bez symbolu
    string alt_symbol = ""; // Dla wezla drzewa nie bedacy symbolem
    int frequency = 0; // Częstość występowania symbolu w źródle
    bool is_on_tree = false; // Flaga sprawdzajaca czy wezel jest juz w drzewie
    string left_child = "nn";
    HuffmanNode *left_child_p = NULL;
    string right_child = "nn";
    HuffmanNode *right_child_p = NULL;
    string parent = "nn";
    HuffmanNode *parent_p = NULL;
    string code = ""; // kod znaku
}typedef HuffmanNode;

vector<HuffmanNode> huffmanNodesArray(50); //tablica symboli, stanie sie tablica wezlow drzewa

void GenerateModelFromFile(HuffmanNode *huffmanModelArray, char *inputFile, int *readedBytesCount){
    // Wyznacza model dla zadanego pliku i zapisuje go w odpowiedniej strukturze
    
    FILE *inputFileHandle = fopen(inputFile, "rb");

    int readCount = 0;
    unsigned char buffer[1];
    int readBytesLength = 1;
    int countBytesReaded = 0;

    while(readCount = fread(buffer, sizeof(unsigned char), readBytesLength, inputFileHandle)){
        //Obsługa odczytanego bajtu
    	huffmanModelArray[buffer[0]].frequency++;
        countBytesReaded++;
    }

    *readedBytesCount = countBytesReaded;

    fclose(inputFileHandle);
};

void WriteModelToFile(HuffmanNode *huffmanModelArray, char *outputModelFile, int readedBytesCount){
    // Zapisuje wyznaczony model do pliku tekstowego (z odpowiednim formatowaniem)
    
    FILE *outputFileHandle;

    if((outputFileHandle = fopen(outputModelFile, "w")) == NULL){
        printf("Nie powiodlo sie otworzenie pliku %s do zapisu \n", outputModelFile);
    }
    else{
        fprintf(outputFileHandle, "%d\n", readedBytesCount);

        int i;
        for(i=0;i<MODEL_ARR_LEN;i++){
            if(huffmanModelArray[i].frequency != 0){
                fprintf(outputFileHandle, "%d:%d\n", huffmanModelArray[i].symbol, huffmanModelArray[i].frequency);
            }
        } 
    }
    fclose(outputFileHandle);
};

int CompareHuffmanNodes (const void *item1, const void *item2) {
    // Funkcja pomocnicza do sortowania modelu

    HuffmanNode *node1 = (HuffmanNode *)item1;
    HuffmanNode *node2 = (HuffmanNode *)item2;
    
    int compareResult = (node1->frequency - node2->frequency);

    if(compareResult == 0){
        compareResult = (node1->symbol - node2->symbol);
    }

    return -compareResult;
}

void SortHuffmanModel(HuffmanNode *huffmanModelArray, int modelArrayLength){
    // Sortuje tablicę modelu - najpierw po częstości, potem po wartości ASCII rosnąco
    qsort(huffmanModelArray, modelArrayLength, sizeof(HuffmanNode), CompareHuffmanNodes);
};

void GenerateHuffmanTreeFromModel(HuffmanNode *huffmanModelArray){
    // Generuje drzewo kodowania

    int nonSymbolIterator = 1;

    huffmanNodesArray.erase(huffmanNodesArray.begin(),huffmanNodesArray.end());

    int i;
    for(i=0;i<MODEL_ARR_LEN;i++){
    	if(huffmanModelArray[i].frequency > 0){
            huffmanNodesArray.push_back(huffmanModelArray[i]);
        }
	};
    reverse(huffmanNodesArray.begin(), huffmanNodesArray.end());

    for(int i=0;i<huffmanNodesArray.size();i++){
        huffmanNodesArray[i].left_child_p = NULL;
        huffmanNodesArray[i].right_child_p = NULL;
        huffmanNodesArray[i].parent_p = NULL;
    }

    bool loop = true;
    while(loop){

        // znajdz 2 o najmniejszej czestosci
        int ind1 = -1, ind2 = -1;
        for(int i=0;i<huffmanNodesArray.size();i++){
            if(!huffmanNodesArray[i].is_on_tree){
                int indt = i;
                int minfreq = huffmanNodesArray[i].frequency;
                for(int j=0;j<huffmanNodesArray.size();j++){
                    if(!huffmanNodesArray[j].is_on_tree && minfreq >= huffmanNodesArray[j].frequency && j != ind1){
                        minfreq = huffmanNodesArray[j].frequency;
                        indt = j;
                    }
                }
                if(ind1 == -1){
                    ind1 = indt;
                }
                else if(ind1 != indt){
                    ind2 = indt;
                    break;
                }
            }
        }

        if(ind2 == -1){ // kiedy jest tylko 1 nie na drzewie - ostatnia iteracja
            huffmanNodesArray[ind1].is_on_tree = true;
            loop = false;
        }
        else{ // kiedy sa jeszce 2 nie na drzewie

            // nowy wezel laczacy 2 poprzednie
            HuffmanNode newNonSymbolNode;
            newNonSymbolNode.is_symbol = false;
            string newNonSymbolNodeName = "";
            newNonSymbolNodeName.append("#" + to_string(nonSymbolIterator++));
            newNonSymbolNode.alt_symbol = newNonSymbolNodeName;
            newNonSymbolNode.frequency = huffmanNodesArray[ind1].frequency + huffmanNodesArray[ind2].frequency;

            // pokrewienstwo
            huffmanNodesArray[ind1].parent = newNonSymbolNode.alt_symbol;
            huffmanNodesArray[ind2].parent = newNonSymbolNode.alt_symbol;
            if(huffmanNodesArray[ind1].is_symbol){
                string s(1, huffmanNodesArray[ind1].symbol);
                newNonSymbolNode.left_child = s;
            }
                //newNonSymbolNode.right_child = huffmanNodesArray[ind1].symbol;
            else
                newNonSymbolNode.left_child = huffmanNodesArray[ind1].alt_symbol;
            newNonSymbolNode.left_child_p = &(huffmanNodesArray[ind1]);

            if(huffmanNodesArray[ind2].is_symbol){
                string s(1, huffmanNodesArray[ind2].symbol);
                cout << " S ";
                newNonSymbolNode.right_child = s;
            }
                //newNonSymbolNode.right_child = huffmanNodesArray[ind2].symbol;
            else{
                cout << " N ";
                newNonSymbolNode.right_child = huffmanNodesArray[ind2].alt_symbol;
            }
            cout << endl << "SIEMA " << newNonSymbolNode.right_child << " x ";
            cout << huffmanNodesArray[ind2].symbol << " x " << huffmanNodesArray[ind2].alt_symbol << endl;
            newNonSymbolNode.right_child_p = &(huffmanNodesArray[ind2]);

            // dodawanie do drzewa
            huffmanNodesArray.push_back(newNonSymbolNode);
            huffmanNodesArray[huffmanNodesArray.size()-1].is_symbol = false;
            huffmanNodesArray[huffmanNodesArray.size()-1].alt_symbol= newNonSymbolNodeName;
            huffmanNodesArray[huffmanNodesArray.size()-1].frequency = huffmanNodesArray[ind1].frequency + huffmanNodesArray[ind2].frequency;

            huffmanNodesArray[huffmanNodesArray.size()-1].left_child_p = &(huffmanNodesArray[ind1]);
            huffmanNodesArray[huffmanNodesArray.size()-1].right_child_p = &(huffmanNodesArray[ind2]);
            huffmanNodesArray[huffmanNodesArray.size()-1].parent_p = NULL;

            huffmanNodesArray[ind1].parent_p = &huffmanNodesArray[huffmanNodesArray.size()-1];
            huffmanNodesArray[ind2].parent_p = &huffmanNodesArray[huffmanNodesArray.size()-1];

            huffmanNodesArray[ind1].is_on_tree = true;
            huffmanNodesArray[ind2].is_on_tree = true;
        }
    }
};

void PrintTreeModel(){
    cout << endl << "Wygenerowane wezly drzewa kodowania" << endl;
    cout << "s i a\tf  i l  r  p  c\tlp\trp\tpp" << endl;
    cout<<"-----------------------------------------------\n";
    for(int i=0;i<huffmanNodesArray.size();i++){
        // symbol
        if(huffmanNodesArray[i].symbol)
            cout << huffmanNodesArray[i].symbol << " ";
        else
            cout << "  ";
        cout << huffmanNodesArray[i].is_symbol << " ";
        cout << huffmanNodesArray[i].alt_symbol << "\t";
        // frequency
        if(huffmanNodesArray[i].frequency > 10)
            cout << huffmanNodesArray[i].frequency << " ";
        else
            cout << huffmanNodesArray[i].frequency << "  ";
        cout << huffmanNodesArray[i].is_on_tree << " ";
        // left_child
        if(huffmanNodesArray[i].left_child.length() == 1)
            cout << huffmanNodesArray[i].left_child << "  ";
        else if(huffmanNodesArray[i].left_child.length() == 2)
            cout << huffmanNodesArray[i].left_child << " ";
        else if(huffmanNodesArray[i].left_child.length() == 3)
            cout << huffmanNodesArray[i].left_child << "";
        else
            cout << "ERROR";
        // right_child
        if(huffmanNodesArray[i].right_child.length() == 1)
            cout << huffmanNodesArray[i].right_child << "  ";
        else if(huffmanNodesArray[i].right_child.length() == 2)
            cout << huffmanNodesArray[i].right_child << " ";
        else if(huffmanNodesArray[i].right_child.length() == 3)
            cout << huffmanNodesArray[i].right_child << "";
        else
            cout << "ERROR";
        // parent
        if(huffmanNodesArray[i].parent.length() == 1)
            cout << huffmanNodesArray[i].parent << "  ";
        else if(huffmanNodesArray[i].parent.length() == 2)
            cout << huffmanNodesArray[i].parent << " ";
        else if(huffmanNodesArray[i].parent.length() == 3)
            cout << huffmanNodesArray[i].parent << "";
        else
            cout << "ERROR";
        // code
        cout << huffmanNodesArray[i].code << "\t";
        // left_child_p
        if(huffmanNodesArray[i].left_child_p)
            if(huffmanNodesArray[i].left_child_p->symbol)
                cout << huffmanNodesArray[i].left_child_p->symbol << "\t";
            else
                cout << huffmanNodesArray[i].left_child_p->alt_symbol << "\t";
        else
            cout << "nn\t";
        // right_child_p
        if(huffmanNodesArray[i].right_child_p)
            cout << huffmanNodesArray[i].right_child_p->symbol << huffmanNodesArray[i].right_child_p->alt_symbol << "\t";
        else
            cout << "nn\t";
        // parent_p
        if(huffmanNodesArray[i].parent_p)
            if(huffmanNodesArray[i].parent_p->symbol)
                cout << huffmanNodesArray[i].parent_p->symbol << "\t";
            else
                cout << huffmanNodesArray[i].parent_p->alt_symbol << "\t";
        else
            cout << "nn" << "\t";

        cout << endl;
    }
    cout << endl;
};

void WriteHuffmanTreeToFile(char* outputTreeFile){
    // Zapisuje drzewo kodowania do pliku

    reverse(huffmanNodesArray.begin(), huffmanNodesArray.end());
    ofstream treefile;
    treefile.open(outputTreeFile);
    treefile << "wezel czestosc left_child right_child parent" << endl;
    for(int i=0;i<huffmanNodesArray.size();i++){
        if(huffmanNodesArray[i].is_symbol)
            treefile << huffmanNodesArray[i].symbol << " ";
        else
            treefile << huffmanNodesArray[i].alt_symbol << " ";
        treefile << huffmanNodesArray[i].frequency << " ";
        treefile << huffmanNodesArray[i].left_child << " ";
        treefile << huffmanNodesArray[i].right_child << " ";
        treefile << huffmanNodesArray[i].parent << endl;
    };
    treefile.close();
    reverse(huffmanNodesArray.begin(), huffmanNodesArray.end());
};

void GenerateCodeTableFromTree(HuffmanNode* currentHuffmanNode){
    // Generuje kody znakow w ramach struktury

    if(currentHuffmanNode->is_symbol == false){

        currentHuffmanNode->left_child_p->code = currentHuffmanNode->code + "0";
        currentHuffmanNode->right_child_p->code = currentHuffmanNode->code + "1";
        
        GenerateCodeTableFromTree(currentHuffmanNode->left_child_p);
        GenerateCodeTableFromTree(currentHuffmanNode->right_child_p);
    }
};

void WriteCodeTableToFile(char* outputCodeFile){
    // Zapisuje kody znakow do pliku

    reverse(huffmanNodesArray.begin(), huffmanNodesArray.end());
    ofstream codefile;
    codefile.open(outputCodeFile);
    codefile << "znak kod dlugosc_kodu" << endl;
    for(int i=0;i<huffmanNodesArray.size();i++){
        if(huffmanNodesArray[i].is_symbol){
            codefile << (int)huffmanNodesArray[i].symbol << " ";
            codefile << huffmanNodesArray[i].code << " ";
            codefile << huffmanNodesArray[i].code.length() << endl;
        }
    };
    codefile.close();
    reverse(huffmanNodesArray.begin(), huffmanNodesArray.end());
};

int main(){

    cout << endl << "START programu do kodowania huffmana" << endl << endl;

    HuffmanNode huffmanModelArray[MODEL_ARR_LEN]; // tablica symboli

    char inputFile[] = "input.bin";
    char outputModelFile[] = "output_model.txt";
    char outputTreeFile[] = "output_tree.txt";
    char outputCodeFile[] = "output_code.txt";
    int readedBytesCount = 0;
    
    //Wypełnianie struktury symbolami oraz 
    int i;
    for(i=0;i<MODEL_ARR_LEN;i++){
    	huffmanModelArray[i].symbol = (char)i;
        huffmanModelArray[i].is_symbol = true;
	}

    cout << "plik wejsciowy: " << inputFile << endl;
    cout << "plik wyjsciowy modelu: " << outputModelFile << endl;
    cout << "plik wyjsciowy drzewa: " << outputTreeFile << endl;
    cout << "plik wyjsciowy kodu: " << outputCodeFile << endl;
    cout << endl;    

    GenerateModelFromFile(huffmanModelArray, inputFile, &readedBytesCount);
    SortHuffmanModel(huffmanModelArray, MODEL_ARR_LEN);
    WriteModelToFile(huffmanModelArray, outputModelFile, readedBytesCount);
    cout << "Zapisano model" << endl;

    GenerateHuffmanTreeFromModel(huffmanModelArray);
    WriteHuffmanTreeToFile(outputTreeFile);
    cout << "Zapisano drzewo" << endl;

    GenerateCodeTableFromTree(&huffmanNodesArray[huffmanNodesArray.size()-1]);
    WriteCodeTableToFile(outputCodeFile);
    cout << "Zapisano kody znakow" << endl;

    cout << endl << "KONIEC programu do kodowania huffmana" << endl << endl;

	return 0;
}
