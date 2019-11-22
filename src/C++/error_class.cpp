#include "error_class.h"
#include <sstream>
#include <cmath>

Error_class::Error_class () 
{
    string_code_output = "virgin";
}


string Error_class::get_error_message (int code_output)
{
    string message;
    unsigned code;
    ostringstream temp;
    temp << code_output;

    if (code_output >= 0)
    {
        message = "Code " + temp.str() + " is not an error code";
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

void Error_class::set_code_output (string return_message)
{
    string_code_output = return_message;
}

int Error_class::get_code_output ()
{
    return int_code_output;
}



ostream & operator << (ostream & output, Error_class error_obj)
{
    if (error_obj.string_code_output != "virgin")
    {
        output << error_obj.get_error_message (error_obj.string_code_output) << endl;
	error_obj.string_code_output = "virgin";
	return output;
    }

    return output << error_obj.get_error_message (error_obj.int_code_output) << endl;
}

