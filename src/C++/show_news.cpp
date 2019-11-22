#include <iostream>
#include <string>
#include <fstream>
#include "constants.h"
#include "show_news.h"

using namespace std;

int show_news (string news_filename){
    
    ifstream file;
    string line;

    if (news_filename.length() == 0){
        cout << "ERROR: Blank filename" << endl;
    }

    file.open(news_filename);
    if (file.is_open()){
        while (getline (file, news_line)) {
            cout << line << endl;
        }
    }
    //cout << "Could not open file " << news_filename << endl;
    return NEWS_FILE_ERROR; 
    
}