#include <iostream>
#include <fstream>
#include <string>
#include "list_less_serious.h"

using namespace std;

int main (){
    string filename = "classification_test.txt";
    unsigned return_value;

    return_value = list_less_serious (filename);
    cout << "Valor de Retorno: " << return_value << endl;

    return 0;
}
