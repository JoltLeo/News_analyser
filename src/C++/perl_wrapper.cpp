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
    my_argv[0] = (char *) "";
    my_argv[1] = perl_code_path;
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
    call_pv("classify_news", G_SCALAR);
    SPAGAIN;
    
    resultado = POPi;
    PUTBACK;
    FREETMPS;
    LEAVE;

    return resultado;
}


void Perl_wrapper::set_blacklist (string blacklist_path)
{
    blacklist_file = blacklist_path;
}

void Perl_wrapper::set_curse_words (string curse_words_path);
{
    curse_words_file = curse_words_path;
}

string Perl_wrapper::get_blacklist ()
{
    return blacklist_file;
}

string Perl_wrapper::get_curse_words ()
{
    return curse_words_file;
}