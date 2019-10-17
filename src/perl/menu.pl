use strict;
use warnings;

sub print_menu{
    print "---------------------------------------------------------------------------";
    print "                             Menu                                          ";
    print "---------------------------------------------------------------------------";
    print "|Digite 0 para sair do programa                                           |";
    print "|Digite 1 para verificar se o autor esta na blacklist                     |";
    print "|Digite 2 para classificar o assunto da noticia                           |";
    print "|Digite 3 para verificar se a noticia possui autor e data                 |";
    print "|Digite 4 para contar os artificios menos serios da noticia               |";
    print "|Digite 5 para classificar a seriedade da noticia                         |";
    print "---------------------------------------------------------------------------";
}

my $pressed_key;
my $quit_loop = 0;
my $file_name;
my $blacklist_file_name;
my $std_blacklist = "blacklist";
my $return_value;

while ($quit_loop == 0){
    print_menu();
    print "\nEntre com a opcao desejada: ";
    $pressed_key = <STDIN>;
    chomp $pressed_key; #Removes \n at the end of the string

    if ($pressed_key < 6 && $pressed_key > 0){
        if ($pressed_key == 1){
            print "Entre com o arquivo contendo a noticia: ";
            $file_name = <STDIN>;
            chomp $file_name;

            print "Entre com o arquivo da blacklist. Caso queira utilizar a blacklist padrao, pressione ENTER: "
            $blacklist_file_name = <STDIN>;
            chomp $blacklist_file_name;

            if ($blacklist_file_name eq ""){
                $return_value = check_author_and_source($file_name, $std_blacklist,2);
                if ($return_value == -1){
                    print "Erro ao executar a funcao check_author_and_source";
                }
                $return_value = check_author_and_source($file_name, $std_blacklist,4);
                if ($return_value == -1){
                    print "Erro ao executar a funcao check_author_and_source";
                }
            } else{
                $return_value = check_author_and_source($file_name, $blacklist_file_name,2);
                if ($return_value == -1){
                    print "Erro ao executar a funcao check_author_and_source";
                }
                $return_value = check_author_and_source($file_name, $blacklist_file_name,4);
                if ($return_value == -1){
                    print "Erro ao executar a funcao check_author_and_source";
                }
            }
        }
        if ($pressed_key == 2){
            print "Entre com o arquivo contendo a noticia: ";
            $file_name = <STDIN>;
            chomp $file_name;

            my $return_value = classify_subject($file_name);
            if ($return_value == -1){
                print "Erro ao executar a funcao news_subject_classification";
            }
        }
        if ($pressed_key == 3){
            print "Entre com o arquivo contendo a noticia: ";
            $file_name = <STDIN>;
            chomp $file_name;

            $return_value = check_news_format($file_name);
            if ($return_value == -1){
                print "Erro ao executar a funcao check_author_and_source";
            }
        }
        if ($pressed_key == 4){
            print "Entre com o arquivo contendo a noticia: ";
            $file_name = <STDIN>;
            chomp $file_name;

            $return_value = check_artifacts($file_name);
            if ($return_value == -1){
                print "Erro ao executar a funcao check_author_and_source";
            }
        }
        if ($pressed_key == 5){
            print "Entre com o arquivo contendo a noticia: ";
            $file_name = <STDIN>;
            chomp $file_name;

            my @return_values = classify_news($file_name);
            if ($return_values[0] == -1){
                print "Erro ao executar a funcao classify_news";
            }
        }

    }
    elsif ($pressed_key == 0){
        print "---------------------------------------------------------------------------";
        print "                             Goodbye!                                      ";
        print "---------------------------------------------------------------------------";
        $quit_loop = 1;
    }
    else{
        print "--------------------------------------------------------------------------";
        print "  Essa nao e uma opcao. Selecione a opcao a partir do menu! ¯\\_(ツ)_/¯   ";
        print "--------------------------------------------------------------------------";
    }
} 