#include <iostream>
#include <string>
#include "perl_wrapper.h"

using namespace std;

int main ()
{
    Perl_wrapper perl_wrapper;
    perl_wrapper.interpreter ("../perl/modules/classify_news.pm");
    int result;
    result = perl_wrapper.classify_news ("noticia.txt");
    cout << "\n\nRetorno: " << result << endl;
    return 0;
}

