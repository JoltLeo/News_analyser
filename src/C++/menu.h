#ifndef MENU_H
#define MENU_H

#include <iostream>
#include <fstream>
#include <string>
#include <string.h>
#include <cstdlib>
#include <cstdio>
#include <unistd.h>
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
        void menu_show_news ();
        void menu_list_less_serious ();
        void menu_classify_news ();
        void menu_change_blacklist ();
        void menu_classification_statistics ();
        void set_input_news_file ();
        void set_input_blacklist_file ();
        void set_input_curse_words_file ();

    private:
        // inpust [0] = news file path
        //inputs [1] = blacklist file path
        //inputs [2] = curse words file path
        vector <string> inputs{(string)"noticia.txt", (string)"blacklist.txt", (string)"curse_words.txt"};
};


#endif
