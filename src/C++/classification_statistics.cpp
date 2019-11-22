#include <string>
#include <iostream>
#include <fstream>
#include "constants.h"
#include "classification_statistics.h"

using namespace std;

int classification_statistics(){
    unsigned counter_serious = 0;
    unsigned counter_less_serious = 0;
    unsigned ratio = 0;

    size_t serious_position;
    size_t less_serious_position;

    string line;
    ifstream classification_file;

    classification_file.open();
    if (!classification_file.is_open()){
        return CLASSIFICATION_FILE_ERROR;
    }

    while (getline(line,classification_file)){
        serious_position = line.find (SERIOUS);
        less_serious_position = line.find(LESS_SERIOUS);

        if((!serious_position) && (!less_serious_position)){
            classification_file.close();
            return CORRUPTED_FILE;
        }
        if (serious_position != string::npos){
            counter_serious ++;
        }else{
            counter_less_serious ++;
        }
    }

    cout << "----------------------------------------------------------------" << endl;
    cout << "|    NUMBER OF NEWS    |   SERIOUS NEWS    | LESS SERIOUS NEWS |" << endl;
    cout << "----------------------------------------------------------------" << endl;
    cout << "       " <<  counter_less_serious + counter_serious << "              " << counter_serious << "       " << counter_less_serious << endl;
    cout << "----------------------------------------------------------------" << endl;
}
