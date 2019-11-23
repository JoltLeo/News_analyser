#include <iostream>
#include <fstream>
#include <string>
#include "show_news.h"
#include "constants.h"

using namespace std;

int main (){
    int return_value;
    string arquivo = "noticia.txt";
    return_value = show_news (arquivo);
    cout << "Valor de Retorno: " << return_value << endl;
    return 0;
}
