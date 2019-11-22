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
    "ERROR: Blank news filename on function show_news on show_news.cpp\n"
};


#endif
