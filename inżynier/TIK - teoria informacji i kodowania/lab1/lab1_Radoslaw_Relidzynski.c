#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#define MODEL_ARR_LEN 256

struct HuffmanNode {
    unsigned char symbol; // Faktyczny symbol
    int frequency; // Częstość występowania symbolu w źródle
};
typedef struct HuffmanNode HuffmanNode;

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

void WriteModelToFile(HuffmanNode *huffmanModelArray, char *outputFile, int readedBytesCount){
    // Zapisuje wyznaczony model do pliku tekstowego (z odpowiednim formatowaniem)
    
    FILE *outputFileHandle;

    if((outputFileHandle = fopen(outputFile, "w")) == NULL){
        printf("Nie powiodlo sie otworzenie pliku %s do zapisu \n", outputFile);
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

int main(){
    HuffmanNode huffmanModelArray[MODEL_ARR_LEN];
    char inputFile[] = "input.bin";
    char outputFile[] = "output.txt";
    int readedBytesCount = 0;
    
    //Wypełnianie struktury symbolami oraz 
    int i;
    for(i=0;i<MODEL_ARR_LEN;i++){
    	huffmanModelArray[i].symbol = (char)i;
    	huffmanModelArray[i].frequency = 0;
	}

    GenerateModelFromFile(huffmanModelArray, inputFile, &readedBytesCount);

    SortHuffmanModel(huffmanModelArray, MODEL_ARR_LEN);

    WriteModelToFile(huffmanModelArray, outputFile, readedBytesCount);

	return 0;
}
