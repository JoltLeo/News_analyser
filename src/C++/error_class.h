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
    friend ostream & operator << (ostream &, const Error_class);

    public:
        string get_error_message (int = int_code_output);
        string get_error_message (string);
        void set_code_output (int);
        int get_code_output ();

    private:
        int int_code_output;
};

#endif