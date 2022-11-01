#include<iostream>
#include<string>
#include<sstream>
#include<fstream>
#include<bits/stdc++.h>
using namespace std;

int m = 0xEDB88320;
unsigned int crc_tab[256];

int ConvertToDecimal(int d, string s){
    if(d==1){
        if((s[0] - 55) < 10){
            return int(s[0] - 48);
        }
        else{
            return int(s[0] - 55);
        }
    }
    else{
        if((s[d-1] - 55) < 10){
            return 16 * ConvertToDecimal(d-1, s) + int(s[d-1] - 48);
        }
        else{
            return 16 * ConvertToDecimal(d-1, s) + int(s[d-1] - 55);
        }
    }
}

unsigned int CalculateCRC(string input){

    unsigned int crc = 0xFFFFFFFF, cond;

    for(unsigned char x : input){
        crc=(crc>>8) ^ crc_tab[(crc ^ x) & 0xFF];
    }

    return ~crc;
}

int main(){

    unsigned int tmp;
    // crc_tab has all values needs for crc calculation equation
    for(int i=0; i<256; i++){
        tmp=i;
        for(int j=0; j<8; j++){
            tmp=(tmp >> 1) ^ (tmp%2 * m);
        }
        crc_tab[i]=tmp;
    }

    // Open file
    char input_file_name[] = "smalltest.txt";
    FILE *input_file = fopen(input_file_name, "rb");
    if (!input_file) {
        cout << "Can't open file";
        exit(0);
    }

    // Read text from file
    unsigned char buffer[1];
    string input_text = "";

    while (fread(buffer, sizeof(unsigned char), 1, input_file)){
        input_text += buffer[0];
    }
    fclose(input_file);

    // Choose operation
    cout << "1. Calculate CRC\n2. Check CRC\n";
    int c=-1;
    cin >> c;

    // 1. Calculate CRC
    if(c==1){
        cout << "Calculating CRC\n";
        unsigned int result = CalculateCRC(input_text);
        cout << "Calculated CRC: 0x" << hex << result;

        ofstream input_file;
        input_file.open(input_file_name, ios::out | ios::binary);
        if (!input_file) {
            cout << "Can't open file";
            exit(0);
        }
        input_file.seekp(0, ios_base::end);
        input_file<<input_text;

        string hex_crc;
        unsigned int r = result;
        while(r > 0){
            if(r % 16 >= 10) hex_crc = char(r % 16 + 55) + hex_crc;
            else hex_crc = to_string(r % 16) + hex_crc;
            r /= 16;
        }

        string tmp, add, crc_s;
        for(int i=0; i<hex_crc.length(); i+=2){
            tmp+=hex_crc[i];
            tmp+=hex_crc[i+1];
            add = char(ConvertToDecimal(2, tmp));
            crc_s += add;
            input_file<<char(add[0]);
            tmp.erase();
        }
        cout << "\nAdded " << crc_s << " to file\n";
    }

    // 2. Check CRC
    if(c==2){
        string crc = input_text.substr(input_text.length()-4, 4);
        string crc_hex_test;

        cout << "Calculating CRC\n";
        unsigned int result = CalculateCRC(input_text.substr(0, input_text.length()-4));
        cout << "Calculated CRC:\t0x" << hex << result;

        // Reading CRC
        for(int i=0; i<crc.length(); i++){
            string hex_crc;

            // Convert to hex
            unsigned char r = crc[i];
            while(r > 0) {
                if (r % 16 >= 10) hex_crc = char(r % 16 + 87) + hex_crc;
                else hex_crc = to_string(r % 16) + hex_crc;
                r /= 16;
            }
            crc_hex_test += hex_crc.length() == 2 ? hex_crc : char(48) + hex_crc;
        }

        cout<<"\nReaded CRC:\t0x"<< hex << crc_hex_test <<endl;

        ostringstream r;
        r << hex << result;
        string res = r.str();

        ostringstream xx;
        xx << hex << crc_hex_test;
        string x = xx.str();

        //if(result == ConvertToDecimal(crc_hex_test.length(), crc_hex_test)){
        if(res == x){
            cout<<"CRC is correct";
        }
        else{
            cout<<"File is corrupted, CRC incorrect";
        }
    }

    return 0;
}