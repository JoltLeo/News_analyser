#ifndef ERROR_CLASS_H
#define ERROR_CLASS_H

#include <iostream>
#include <string>
#include <vector>

#include "error_messages.h"

using namespace std;


//Class that handle all the error codes and messages outputs

class Error_class
{
    friend ostream & operator << (ostream &, Error_class);

    public:
	    Error_class ();
        void set_code_output (int);
        void set_code_output (string);
        int get_code_output ();

    private:
        int int_code_output;
	    string string_code_output;
        string get_error_message (int);
        string get_error_message (string);
};

#endif
