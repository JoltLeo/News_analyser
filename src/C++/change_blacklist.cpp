#include <iostream>
#include <fstream>
#include <string>
#include <string.h>
#include <cstdlib>
#include <cstdio>
#include <unistd.h>
#include "constants.h"
#include "change_blacklist.h"


using namespace std;

int add_to_blacklist (string blacklist, string name_to_add){
    char temporary_filename [MAXIMUM_FILENAME_LENGTH] = "tmpFile.XXXXXX";
    char swap_filename [MAXIMUM_FILENAME_LENGTH] = "swp.XXXXXX";
    char blacklist_filename [MAXIMUM_FILENAME_LENGTH];
    int file_descriptor;
    int result;
    string line;
    ifstream blacklist_file;
    ofstream temporary_file;

    strcpy (blacklist_filename, blacklist.c_str());

    blacklist_file.open(blacklist);
    if (!blacklist_file.is_open()){
        //cout << "ERROR: Could not open blacklist file" << endl;
        return BLACKLIST_FILE_ERROR_ADD;
    } 


    file_descriptor = mkstemp(temporary_filename);
    if (file_descriptor == -1){
        //cout << "ERROR: Could not open temporary file" << endl;
        return TEMPORARY_FILE_ERROR_ADD; 
    }

    temporary_file.open(temporary_filename);
    if (!temporary_file.is_open()){
        //cout << "ERROR: Could not open temporary file" << endl;
        return TEMPORARY_FILE_ERROR_ADD;
    }

    while (getline (blacklist_file, line)){
        temporary_file << line << endl;
    }

    temporary_file << name_to_add;

    temporary_file.close();
    blacklist_file.close();

    file_descriptor = mkstemp(swap_filename);
    if (file_descriptor == -1){
        //cout << "ERROR: Could not open temporary file" << endl;
        return TEMPORARY_FILE_ERROR_ADD; 
    }

    result = rename (blacklist_filename, swap_filename);
    if (result){
        //cout << "Error renaming blacklist file" << endl;
        remove (temporary_filename);
        return RENAMING_BLACKLIST_ERROR_ADD;
    }
    result = rename (temporary_filename, blacklist_filename);
    if (result){
        //cout << "Error renaming temporary file" << endl;
        rename (swap_filename, blacklist_filename);
        remove (temporary_filename);
        return RENAMING_TEMPORARY_ERROR_ADD;
    }
    remove(swap_filename);

    return SUCCESS;
    
}

int remove_from_blacklist (string blacklist, string name_to_add){
    char temporary_filename [MAXIMUM_FILENAME_LENGTH] = "tmpFile.XXXXXX";
    char swap_filename [MAXIMUM_FILENAME_LENGTH] = "swp.XXXXXX";
    char blacklist_filename [MAXIMUM_FILENAME_LENGTH];
    int file_descriptor;
    int result;
    unsigned counter = 0;
    string line;
    ifstream blacklist_file;
    ofstream temporary_file;

    strcpy (blacklist_filename, blacklist.c_str());

    blacklist_file.open(blacklist);
    if (!blacklist_file.is_open()){
        //cout << "ERROR: Could not open blacklist file" << endl;
        return BLACKLIST_FILE_ERROR_REMOVE;
    } 


    file_descriptor = mkstemp(temporary_filename);
    if (file_descriptor == -1){
        //cout << "ERROR: Could not open temporary file" << endl;
        return TEMPORARY_FILE_ERROR_REMOVE; 
    }

    temporary_file.open(temporary_filename);
    if (!temporary_file.is_open()){
        //cout << "ERROR: Could not open temporary file" << endl;
        return TEMPORARY_FILE_ERROR_REMOVE;
    }

    while (getline (blacklist_file, line)){
        if (line.compare(name_to_add) != 0){
            if (counter == 0){
                temporary_file << line;
            }else{
                temporary_file << endl << line;
            }
            counter ++;
        }
    }

    temporary_file.close();
    blacklist_file.close();

    file_descriptor = mkstemp(swap_filename);
    if (file_descriptor == -1){
        //cout << "ERROR: Could not open temporary file" << endl;
        return TEMPORARY_FILE_ERROR_REMOVE; 
    }

    result = rename (blacklist_filename, swap_filename);
    if (result){
        //cout << "Error renaming blacklist file" << endl;
        remove (temporary_filename);
        return RENAMING_BLACKLIST_ERROR_REMOVE;
    }
    result = rename (temporary_filename, blacklist_filename);
    if (result){
        //cout << "Error renaming temporary file" << endl;
        rename (swap_filename, blacklist_filename);
        remove (temporary_filename);
        return RENAMING_TEMPORARY_ERROR_REMOVE;
    }
    remove(swap_filename);
    
    return SUCCESS;
}
