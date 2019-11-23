#ifndef MENU_H
#define MENU_H

#include <iostream>
#include <string>
#include <vector>

#include "error_messages.h"
#include "change_blacklist.h"
#include "classification_statistics.h"
#include "constants.h"
#include "error_class.h"
#include "error_messages.h"
#include "list_less_serious.h"
#include "perl_wrapper.h"
#include "show_news.h"

using namespace std;

void show_menu ();
int add_to_classification_file (string, int);

class Menu
{
    public:
        string get_news_title (string);
        void show_news ();
        void list_less_serious ();
        void classify_news ();
        void chance_blacklist ();
        void classification_statistics ();
        void set_input_news_file ();
        void set_input_blacklist_file ();
        void set_input_curse_words_file ();

    private:
        // inpust [0] = news file path
        //inputs [1] = blacklist file path
        //inputs [2] = curse words file path
        static vector <string> inputs [3];
}


#endif