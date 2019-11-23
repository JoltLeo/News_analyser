#include <iostream>
#include <fstream>
#include <string>
#include "constants.h"
#include "change_blacklist.h"

int main (){
    string file = "blacklist.txt";
    string name = "teste";

    add_to_blacklist (file, name);
    //remove_from_blacklist (file,name);
    return 0;    
}
