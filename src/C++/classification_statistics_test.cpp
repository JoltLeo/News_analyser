#include <iostream>
#include <fstream>
#include <string>
#include "classification_statistics.h"
#include "constants.h"

using namespace std;

int main (){
    
    string filename = "classification_test.txt";
    int return_value;

    return_value = classification_statistics (filename);
    cout << "Valor do Retorno: " << return_value << endl;    

    return 0;
}
