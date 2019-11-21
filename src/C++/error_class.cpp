#include "error_class.h"

string Error_class::get_error_message (int code_output)
{
    string message;
    unsigned code;

    if (code_output >= 0)
    {
        message = "Code " + to_string(code_output) + " is not an error code";
        return message;
    }

    code = (unsigned) abs (code_output);
    message = error_messages [code];
    return message;
}

string Error_class::get_error_message (string string_output)
{
    if (string_output == "")
    {
        return error_messages [0];
    }

    return "Ok";
}


void Error_class::set_code_output (int number)
{
    if (number >= 0)
    {
       cout << "Code " << number << " is not an error code" << endl; 
    }
    else
    {
        int_code_output = number;
    }   
}

int Error_class::get_code_output ()
{
    return int_code_output;
}