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
    "ERROR: Could not rename temporary file on function remove_from_blacklist on change_blacklist.cpp\n",// -12
    "ERROR: There are no authors on the news on function check_news_format.pm\n", //-13
    "ERROR: Data format at news file is wrong on function check_news_format.pm. Right format: 24/11/2019\n", //-14
    "ERROR: No source on news file on function check_news_format.pm\n", //-15
    "ERROR: Incorrect input on function classify_news.pm\n", //-16
    "ERROR: The news could not be classified by function classify_news.pm\n", //-17
    "ERROR: The news subject could not be defined on function news_subject_classification.pm\n", //-18
    "ERROR: Path input exceed the maximum size allowed on menu.cpp\n", //-19
    "ERROR: Could not open news classifications file on function add_to_classification_file on menu.cpp\n", //-20
    "ERROR: Could not open temporary file on function add_to_classification_file on menu.cpp\n",// -21
    "ERROR: Could not rename news classifications file on function add_to_classification_file on menu.cpp\n",// -22
    "ERROR: Could not rename temporary file on function add_to_classification_file on menu.cpp\n",// -23
    



};


#endif
