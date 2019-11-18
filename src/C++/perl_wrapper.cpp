#include "perl_wrapper.h"

Perl_wrapper::Perl_wrapper (string blacklist_path, string curse_words_path)
{
    blacklist_file = blacklist_path;
    curse_words_file = curse_words_path;
    PERL_SYS_INIT3(NULL, NULL, NULL);
    my_perl = perl_alloc();
    perl_construct(my_perl);
    PL_exit_flags |= PERL_EXIT_DESTRUCT_END;
}

Perl_wrapper::~Perl_wrapper ()
{
    perl_destruct(my_perl);
    perl_free(my_perl);
    PERL_SYS_TERM();
}


void Perl_wrapper::interpreter (char * perl_code_path)
{
    char _MYARGV_PERL_MODULE_NAME[] = perl_code_path; //remove warnings
    char _MYARGV_NOTHING_NAME[] = ""; //remove warnings
    my_argv[0] = static_cast<char*> (_MYARGV_NOTHING_NAME) ;
    my_argv[1] = static_cast<char*> (_MYARGV_PERL_MODULE_NAME);
    perl_parse(my_perl, 0, 2, my_argv, (char **)NULL);
    perl_run(my_perl);
}

int Perl_wrapper::classify_news (string news_file)
{
    int resultado;
    
    // Reminiscing Professor Brafman classes :)
    dSP; // Initialize Stack Pointer
    ENTER;
    SAVETMPS; //
    PUSHMARK(SP); //Stack Pointer

    //Inserting values into the Stack
    XPUSHs(sv_2mortal(newSVpv(news_file.c_str(), news_file.length()))); 
    XPUSHs(sv_2mortal(newSVpv(blacklist_file.c_str(), blacklist_file.length())));
    XPUSHs(sv_2mortal(newSVpv(curse_words_file.c_str(),curse_words_file.length())));

    PUTBACK;
    call_pv("salvaPerfil", G_SCALAR);
    SPAGAIN;
    
    resultado = POPi;
    PUTBACK;
    FREETMPS;
    LEAVE;

    return resultado;
}