#ifndef PERL_WRAPPER_H
#define PERL_WRAPPER_H

#include <EXTERN.h>
#include <perl.h>
#include <iostream>
#include <string>
#include <vector>

using namespace std;

// Class that handles the interface between Perl and C++
class Perl_wrapper
{
    public:
        // Default blacklist and curse words absolute path
        Perl_wrapper (string = "blacklist.txt", string = "curse_words.txt");
        ~Perl_wrapper ();
        void interpreter (char *);
        int classify_news (string);
        void set_blacklist (string = "blacklist.txt");
        void set_curse_words (string = "curse_words.txt");
        string get_blacklist ();
        string get_curse_words ();
        
    private:
        PerlInterpreter *my_perl;
        string blacklist_file;
        string curse_words_file;
        /* my_argv[0] = ""; my_argv[1] = <perl module name>*/
        char *my_argv[2];

};

#endif
