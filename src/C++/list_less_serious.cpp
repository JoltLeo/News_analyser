#include <string>
#include <iostream>
#include <fstream>
#include "constants.h"
#include "list_less_serious.h"


using namespace std;
//Classification file pattern: Title=classification

int list_less_serious (string filename){

    string line;
    string title;
    string classification;
    size_t position = 0;
    ifstream classification_file;

    classification_file.open(filename);
    if(!classification_file.is_open()){
        //cout << "ERROR: Could not find classification file" << endl;
        return CLASSIFICATION_FILE_ERROR;
    }

    cout << "-------------------------------------------------------------------------" << endl;
    cout << "|                  NOT SO SERIOUS NEWS BY TITLE                         |" << endl;
    cout << "-------------------------------------------------------------------------" << endl;

    while (getline(classification_file, line)){
        position = line.find(DELIMITER);
        if (position == string::npos){
            //cout << "ERROR: Classification file corrupted" << endl;
            classification_file.close();
            return CORRUPTED_FILE;
        }
        title = line.substr(0, line.find(DELIMITER));
        line.erase(0, position + DELIMITER_LENGTH);

        
        if (!line.compare(LESS_SERIOUS)){
            cout << title << endl;
        }
    }

    classification_file.close();
    return SUCCESS;
}
