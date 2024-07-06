#include<iostream>
#include<string>
#include<sstream>
#include<fstream>
#include<bits/stdc++.h>
using namespace std;

unsigned int CalculateCRC(string input)
{
    unsigned int crc = 0xFFFFFFFF, mask;

    for(unsigned int byte: input)
    {
        crc = crc ^ byte; // XOR
        int i=8;
        while(i--)
        {
            if(crc % 2)
                crc = (crc >> 1) ^ 0xEDB88320;
            else
                crc >> 1;
        }
    }
    return ~crc;
}

string handleCRC(string inputfile, string mode)
{
    // input string from file
    ifstream file;
    file.open(inputfile);
    if(!file) {cout<<"No file!\n"; exit(0);}
    string inputstring;
    file >> inputstring;
    file.close();

    // get CRC result in dec
    unsigned int resultCRC = CalculateCRC(inputstring);

    // return result in specified mode
    string result;
    if(mode=="dec")
    {
        result = to_string(resultCRC);
        return result;
    }

    else if(mode=="bin")
    {
        unsigned int code=resultCRC;
        while(code > 0){
            result += to_string(code%2);
            code /= 2;
        }
        reverse(result.begin(), result.end());
        return "0b" + result;
    }

    else if(mode=="oct")
    {
        unsigned int code=resultCRC;
        while(code > 0){
            result += to_string(code%8);
            code /= 8;
        }
        reverse(result.begin(), result.end());
        return "0o" + result;
    }

    else if(mode=="hex")
    {
        stringstream sstream;
        sstream << hex << resultCRC;
        result = sstream.str();
        return "0x" + result;
    } 

    else
    {
        cout << "Wrong mode" << endl;
        exit(0);
    }

    return "ERROR";
}

int main()
{
    string modes[] = {"dec", "bin", "oct", "hex"}; //types of output
    string inputfile="test.txt";
    string mode = modes[3];
    string result;

    cout << "START CRC CALCULATOR" << endl << endl;

    cout << "file: \"" << inputfile << "\"\tmode: \"" << mode << "\"" << endl;
    result = handleCRC(inputfile, mode);
    cout << "The result of CRC calculation is:\n" << result << endl;

    cout << endl << "FINISHED CRC CALCULATION" << endl;
}
