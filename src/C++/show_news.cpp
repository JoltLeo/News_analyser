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
        return BLANK_NEWS_FILENAME;
    }

    file.open(news_filename);
    if (file.is_open()){
        while (getline (file, line)) {
            cout << line << endl;
        }
    }else{
        //cout << "Could not open file " << news_filename << endl;
        return NEWS_FILE_ERROR;
	}
	return SUCCESS; 
    
}
