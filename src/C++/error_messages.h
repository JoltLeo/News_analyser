#ifndef ERROR_MESSAGES_H
#define ERROR_MESSAGES_H

using namespace std;

//All error messages from C++ and Perl
const char * const error_messages [] = 
{
    "The string is empty\n", // error empty string 
    "ERROR: Could not open news file on function show_news on show_news.cpp\n", // error -1
    "ERROR: Classification file corrupted\n", // error -2
    "ERROR: Could not find classification file\n", // -3
    "ERROR: Blank news filename on function show_news on show_news.cpp\n",
    "ERROR: Could not open blacklist file on function add_to_blacklist on change_blacklist.cpp\n",// -5
    "ERROR: Could not open blacklist file on function remove_from_blacklist on change_blacklist.cpp\n",// -6
    "ERROR: Could not open temporary file on function add_to_blacklist on change_blacklist.cpp\n",// -7
    "ERROR: Could not open temporary file on function remove_from_blacklist on change_blacklist.cpp\n",// -8
    "ERROR: Could not rename blacklist file on function add_to_blacklist on change_blacklist.cpp\n",// -9
    "ERROR: Could not rename blacklist file on function remove_from_blacklist on change_blacklist.cpp\n",// -10
    "ERROR: Could not rename temporary file on function add_to_blacklist on change_blacklist.cpp\n",// -11
    "ERROR: Could not rename temporary file on function remove_from_blacklist on change_blacklist.cpp\n"// -12
};


#endif
