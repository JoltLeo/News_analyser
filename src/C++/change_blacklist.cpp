#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
#include <cstdio>
#include <cunistd>
#include "change_blacklist.h"

#define MAXIMUM_FILENAME_LENGTH    25

using namespace std;

void add_to_blacklist (string blacklist, string name_to_add){
    char temporary_filename [MAXIMUM_FILENAME_LENGTH] = "tmpFile.XXXXXX";
    char swap_filename [MAXIMUM_FILENAME_LENGTH] = "swp.XXXXXX";
    int file_descriptor;
    int result;
    string line;
    ifstream blacklist_file;
    ofstream temporary_file;

    blacklist_file.open(blacklist);
    if (!blacklist_file.is_open()){
        cout << "ERROR: Could not open blacklist file" << endl;
        return;
    } 


    file_descriptor = mkstemp(temporary_filename);
    if (file_descriptor == -1){
        cout << "ERROR: Could not open temporary file" << endl;
        return; 
    }

    temporary_file.open(temporary_filename);
    if (!temporary_file.is_open()){
        cout << "ERROR: Could not open temporary file" << endl;
        return;
    }

    while (getline (blacklist_file, line)){
        temporary_file << line;
    }

    temporary_file << "\n" << name_to_add;

    temporary_file.close();
    blacklist_file.close();

    file_descriptor = mkstemp(swap_filename);
    if (file_descriptor == -1){
        cout << "ERROR: Could not open temporary file" << endl;
        return; 
    }

    result = rename (blacklist, swap_filename);
    if (result){
        cout << "Error renaming blacklist file" << endl;
        remove (temporary_filename);
        return;
    }
    result = rename (temporary_filename, blacklist);
    if (result){
        cout << "Error renaming temporary file" << endl;
        rename (swap_filename, blacklist);
        remove (temporary_filename);
        return;
    }
    remove(swap_filename);
    
}

void remove_from_blacklist (string blacklist, string name_to_add){
    char temporary_filename [MAXIMUM_FILENAME_LENGTH] = "tmpFile.XXXXXX";
    char swap_filename [MAXIMUM_FILENAME_LENGTH] = "swp.XXXXXX";
    int file_descriptor;
    int result;
    string line;
    ifstream blacklist_file;
    ofstream temporary_file;

    blacklist_file.open(blacklist);
    if (!blacklist_file.is_open()){
        cout << "ERROR: Could not open blacklist file" << endl;
        return;
    } 


    file_descriptor = mkstemp(temporary_filename);
    if (file_descriptor == -1){
        cout << "ERROR: Could not open temporary file" << endl;
        return; 
    }

    temporary_file.open(temporary_filename);
    if (!temporary_file.is_open()){
        cout << "ERROR: Could not open temporary file" << endl;
        return;
    }

    while (getline (blacklist_file, line)){
        if (line.compare(name_to_add) != 0){
            temporary_file << line;
        }
    }

    temporary_file.close();
    blacklist_file.close();

    file_descriptor = mkstemp(swap_filename);
    if (file_descriptor == -1){
        cout << "ERROR: Could not open temporary file" << endl;
        return; 
    }

    result = rename (blacklist, swap_filename);
    if (result){
        cout << "Error renaming blacklist file" << endl;
        remove (temporary_filename);
        return;
    }
    result = rename (temporary_filename, blacklist);
    if (result){
        cout << "Error renaming temporary file" << endl;
        rename (swap_filename, blacklist);
        remove (temporary_filename);
        return;
    }
    remove(swap_filename);
    
}