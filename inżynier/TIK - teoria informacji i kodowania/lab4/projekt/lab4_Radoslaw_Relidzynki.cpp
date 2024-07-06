#include<iostream>
#include<algorithm>
#include<fstream>
#include<bitset>
#include<map>

using namespace std;

struct HuffmanNode{
    int s;
    int f;
};
typedef struct HuffmanNode HuffmanNode;
vector<HuffmanNode> huffmanModelNodes;
int readedBytesCount = 0;

struct HuffmanNodeTree{
    string s;
    int f;
    string code;
    HuffmanNodeTree *parent;
    HuffmanNodeTree *l_child;
    HuffmanNodeTree *r_child;
};
typedef struct HuffmanNodeTree HuffmanNodeTree;
HuffmanNodeTree *root;

map<string, string> codes;

/////////////
//Kompresja//
/////////////


int CompareHuffmanNodes(HuffmanNode n1, HuffmanNode n2){
    // Funkcja pomocnicza do sortowania modelu

    if(n1.f == n2.f){
        return n1.s > n2.s;
    }
    else{
        return n1.f > n2.f;
    }
}

void GenerateModelFromFile(char* inputTextFile, vector<HuffmanNode> *huffmanModel, int *readedBytesCount){
    // Wyznacza model dla zadanego pliku i zapisuje go w odpowiedniej strukturze

    FILE *textfile = fopen(inputTextFile, "r");
    if(!textfile){cout<<"Nie mozna otworzyc pliku!"; exit(0);}

    int readCount = 0;
    unsigned char buffer[1];
    int readBytesLength = 1;
    int countBytesReaded = 0;
    bool found;

    while (readCount = fread(buffer, sizeof(unsigned char), readBytesLength, textfile)){
        //Obsługa odczytanego bajtu
        found = false;

        // Szukanie w aktualnym zbiorze symboli
        for(HuffmanNode &x : *huffmanModel){
            if(x.s==int(buffer[0])){
                x.f++;
                found = true;
            }
        }

        // Jesli jest to nowy symbol
        if(!found){
            HuffmanNode huffmanNode;
            huffmanNode.s=int(buffer[0]);
            huffmanNode.f=1;
            huffmanModel->push_back(huffmanNode);
        }
        countBytesReaded++;
    }

    *readedBytesCount = countBytesReaded;
    fclose(textfile);

    sort(huffmanModelNodes.begin(), huffmanModelNodes.end(), CompareHuffmanNodes);
}

void WriteModelToFile(char* outputModelFile, vector<HuffmanNode> huffmanModelNodes){
    // Zapisuje wyznaczony model do pliku tekstowego (z odpowiednim formatowaniem)

    ofstream modelfile;
    modelfile.open(outputModelFile);
    if(!modelfile){cout<<"Nie mozna otworzyc pliku!"; exit(0);}

    modelfile << huffmanModelNodes.size() << endl;

    for(HuffmanNode x : huffmanModelNodes){
        modelfile << x.s << ":" << x.f << endl;
    }
    modelfile.close();
}

int CompareHuffmanTreeNodes(HuffmanNodeTree *n1, HuffmanNodeTree *n2){
    // Funkcja pomocnicza do sortowania drzewa
    return n1->f > n2->f;
}

void GenerateHuffmanTreeFromModel(vector<HuffmanNode> huffmanModelNodes){
    // Generuje drzewo kodowania

    vector<HuffmanNodeTree*> huffmanNodeTreeVector;
    for (HuffmanNode x : huffmanModelNodes){
        HuffmanNodeTree *temp = new HuffmanNodeTree;
        temp->s=to_string(x.s);
        temp->f=x.f;
        temp->parent=NULL;
        temp->l_child=NULL;
        temp->r_child=NULL;
        huffmanNodeTreeVector.push_back(temp);
    }

    for(int i=1; huffmanNodeTreeVector.size()!=1; i++){

        HuffmanNodeTree *temp = new HuffmanNodeTree;

        temp->parent=NULL;
        temp->s="#"+ to_string(i);

        temp->l_child = new HuffmanNodeTree;
        temp->l_child=huffmanNodeTreeVector[huffmanNodeTreeVector.size()-1];
        temp->l_child->parent=temp;

        temp->r_child = new HuffmanNodeTree;
        temp->r_child=huffmanNodeTreeVector[huffmanNodeTreeVector.size()-2];
        temp->r_child->parent=temp;

        temp->f = temp->l_child->f + temp->r_child->f;

        huffmanNodeTreeVector.pop_back();
        huffmanNodeTreeVector.pop_back();
        huffmanNodeTreeVector.push_back(temp);

        sort(huffmanNodeTreeVector.begin(), huffmanNodeTreeVector.end(), CompareHuffmanTreeNodes);
    }
    root = huffmanNodeTreeVector[0];

}

void WriteHuffmanTreeToFile_preorder(HuffmanNodeTree *curr, FILE *treefile) {
    // Funkcja pomocnicza dla zapisywania drzewa - przeszukuje w kolejności preorder

    if(curr){
        // Wezel
        fprintf(treefile, "%s ", curr->s.c_str());

        // Czestotliwosc
        fprintf(treefile, "%s ", to_string(curr->f).c_str());

        // Lewy potomek
        if(curr->l_child)
            fprintf(treefile, "%s ", curr->l_child->s.c_str());
        else
            fprintf(treefile, "nn ");

        // Prawy potomek
        if(curr->r_child)
            fprintf(treefile, "%s ", curr->r_child->s.c_str());
        else
            fprintf(treefile, "nn ");

        // Rodzic
        if(curr->parent)
            fprintf(treefile, "%s ", curr->parent->s.c_str());
        else
            fprintf(treefile, "nn ");

        fprintf(treefile, "\n");

        if(curr->l_child != NULL) WriteHuffmanTreeToFile_preorder(curr->l_child, treefile);
        if(curr->r_child != NULL) WriteHuffmanTreeToFile_preorder(curr->r_child, treefile);
    }


}

void WriteHuffmanTreeToFile(char* outputTreeFile, HuffmanNodeTree *root){
    // Zapisuje drzewo kodowania do pliku

    FILE *treefile = fopen(outputTreeFile, "w");
    if(!treefile){cout<<"Nie mozna otworzyc pliku!"; exit(0);}
    
    fprintf(treefile, "wezel czestosc l_child r_child parent\n");
    WriteHuffmanTreeToFile_preorder(root, treefile);
    fclose(treefile);
}

void GenerateCodeTableFromTree(HuffmanNodeTree *curr, string code){
    // Generuje kody znakow - przeszukuje w kolejności preorder

    if(curr){
            curr->code=code;

        if(curr->l_child) GenerateCodeTableFromTree(curr->l_child, code+"0");
        if(curr->r_child) GenerateCodeTableFromTree(curr->r_child, code+"1");
    }
}

void WriteCodeTableToFile_preorder(HuffmanNodeTree *curr, FILE *codefile) {
    // Funkcja pomocnicza dla zapisywania kodów - przeszukuje w kolejności preorder

    if(curr==NULL) return;
    if(curr->s[0] != '#'){
        fprintf(codefile, "%s %s\n", curr->s.c_str(), curr->code.c_str());
    }
    if(curr->l_child != NULL) WriteCodeTableToFile_preorder(curr->l_child, codefile);
    if(curr->r_child != NULL) WriteCodeTableToFile_preorder(curr->r_child, codefile);
}

void WriteCodeTableToFile(char* outputCodeFile, HuffmanNodeTree *root){
    // Zapisuje kody znakow do pliku

    FILE *codefile;
    codefile = fopen(outputCodeFile, "w");
    if(!codefile){cout<<"Nie mozna otworzyc pliku!"; exit(0);}

    fprintf(codefile, "znak kod\n");
    WriteCodeTableToFile_preorder(root, codefile);
    fclose(codefile);
}

string GetSymbolCodeFromTree(HuffmanNodeTree *curr, string symbol){
    // Funkcja zwracajaca kod znakow na podstawie symbolu

    if(curr==NULL) return "";

    // Znaleziony
    if(curr->s==symbol) return curr->code;

    // Szukaj
    if(curr->l_child != NULL)
        if(GetSymbolCodeFromTree(curr->l_child, symbol)!="")
            return GetSymbolCodeFromTree(curr->l_child, symbol);
    if(curr->r_child != NULL)
        if(GetSymbolCodeFromTree(curr->r_child, symbol)!="")
            return GetSymbolCodeFromTree(curr->r_child, symbol);

    // Koncowy element drzewa, nie ten znak
    return "";
}

void WriteCompressedFile(char* input_text_file, char* output_compressed_file, HuffmanNodeTree *root){
    // Funkcja dokonujaca kompresji pliku

    FILE *textfile = fopen(input_text_file, "r");
    if(!textfile){cout<<"Nie mozna otworzyc pliku!"; exit(0);}
    ofstream compressedfile(output_compressed_file, std::ios_base::out | std::ios::binary);
    if(!compressedfile){cout<<"Nie mozna otworzyc pliku!"; exit(0);}

    string binary;
    unsigned char buffer[1];
    if(textfile){
        while(fread(buffer, sizeof(unsigned char), 1, textfile)){
            binary += GetSymbolCodeFromTree(root, to_string(int(buffer[0])));
            if(binary.size()>=8){
                compressedfile << char(stoi(binary.substr(0,8), 0, 2));
                binary.erase(0, 8);
            }
        }
    }
    fclose(textfile);
    if(binary.size()) compressedfile << char(stoi(binary, 0, 2));
    compressedfile.close();
}


///////////////
//Dekompresja//
///////////////


void ImportAndMapCodesFromFile(char* output_code_file, map<string, string> *codes){
    // Funkcja pobierająca tablicę kodową do programu

    ifstream codefile;
    codefile.open(output_code_file);
    if(!codefile){cout<<"Nie mozna otworzyc pliku!"; exit(0);}

    string code, symbol, temp;
    codefile >> symbol >> code;

    while(!codefile.eof()){
        codefile >> symbol >> code;
        codes->insert(pair<string, string>(code, symbol));
    }

    codefile.close();
}

string DecompressCurrentBitset(string *code, map<string, string> codes){
    string result, binary;
    int i=0; // Indeks dla niezdekompresowanych bitow
    for(char c : *code){
        binary+=c;
        if(codes.find(binary) != codes.end()){
            result+=char(stoi(codes.find(binary)->second));
            i+=binary.size();
            binary="";
        }
    }
    *code=code->erase(0, i);
    return result;
}

void WriteDecompressedFile(char* input_compressed_file, char* output_decompressed_file, map<string, string> codes){
    // Dekompresuje plik do pierwotnej postaci

    ifstream compressedfile(input_compressed_file, ios_base::in | ios::binary);
    if(!compressedfile){cout<<"Nie mozna otworzyc pliku!"; exit(0);}
    ofstream decompressedfile;
    decompressedfile.open(output_decompressed_file);
    if(!decompressedfile){cout<<"Nie mozna otworzyc pliku!"; exit(0);}

    string binary, decomp, t;
    unsigned char temp='\0', buffer='\0';

    compressedfile.read((char *) &buffer, 1);
    temp=buffer;
    
    while(compressedfile.read((char *) &buffer, 1)) {
        binary+=bitset<8>(temp).to_string();
        decomp=DecompressCurrentBitset(&binary, codes);
        if(decomp != "") decompressedfile << decomp.c_str();
        temp=buffer;
    }

    // Uzupelnij ostatnim bajtem
    int i = int(temp);
    while(i>0){
        t += to_string(i%2);
        i /= 2;
    }
    reverse(t.begin(), t.end());
    binary+= t;
    decompressedfile << DecompressCurrentBitset(&binary, codes).c_str();

    compressedfile.close();
    decompressedfile.close();
}

int main(int argc, char* argv[]){

    char inputTextFile[] = "smalltest.txt";
    char outputModelFile[] = "output_model.txt";
    char outputTreeFile[] = "output_tree.txt";
    char outputCodeFile[] = "output_code.txt";
    char outputCompressedTextFile[] = "output_compressed.txt";
    char outputDecompressedTextFile[] = "output_decompressed.txt";

    // Compress
    //if(argv[1] == "1"){
        cout << endl << "START kompresji" << endl << endl;

        GenerateModelFromFile(inputTextFile, &huffmanModelNodes, &readedBytesCount);
        WriteModelToFile(outputModelFile, huffmanModelNodes);
        cout << "Zapisano model" << endl;

        GenerateHuffmanTreeFromModel(huffmanModelNodes);
        WriteHuffmanTreeToFile(outputTreeFile, root);
        cout << "Zapisano drzewo" << endl;

        GenerateCodeTableFromTree(root, "");
        WriteCodeTableToFile(outputCodeFile, root);
        cout << "Zapisano kody znakow" << endl;

        cout << endl << "Kodowanie pliku ..." << endl;
        WriteCompressedFile(inputTextFile, outputCompressedTextFile, root);
        cout << "Zapisano zakodowany plik" << endl;

        cout << endl << "KONIEC kompresji" << endl;
    //}


    // Decompress
    //if(argv[1] == "2"){
        cout << endl << "START dekompresji" << endl << endl;

        map<string, string> codes;
        ImportAndMapCodesFromFile(outputCodeFile, &codes);
        cout << "Pobrano kody znakow" << endl;

        cout << endl << "Odkodowanie pliku ..." << endl;
        WriteDecompressedFile(outputCompressedTextFile, outputDecompressedTextFile, codes);
        cout << "Zapisano odkodowany plik" << endl;

        cout << endl << "KONIEC dekompresji" << endl;
    //}

    return 0;
}
