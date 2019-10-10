sub check_emoticons{
    #Recebe e abre o arquivo como argumento
    ($news_file_name) = $_[0];
    open (my $news, "<", $news_file_name) or die "Nao foi possivel abrir o arquivo $news_file_name: $!\n";

    # Lê o texto das notícias e procura por padrões de emoticons 
    my $line;
    my $counter = 0;
    while ($line = <$news>){
        if ($line =~ /[:;][\)D\(\\pO][\s\n!]|[xX][D\\]/){
            $counter ++;
        }
    }

    close $news or die "Nao foi possivel abrir o arquivo $news_file_name: $!\n";

    return ($counter);
}

#A funcao check_first_person verifica a quantidade de palavras que indicam primeira pessoa na notícia. O uso desse fator como métrica é devido ao uso de primeira para expressar opiniao, muito usada em fake news.
#Essa metrica possui peso baixo, uma vez que palavras de primeira pessoa tambem estao presentes em textos serios, geralmente como citaçoes. 
sub check_first_person{
    #Recebe e abre o arquivo como argumento
    ($news_file_name) = $_[0];
    open (my $news, "<", $news_file_name) or die "Nao foi possivel abrir o arquivo $news_file_name: $!\n";

    my $line;
    my $counter = 0;
    while ($line = <$news>){
        if ($line =~ /[Ee]u\s|[Mm]inha\s|[Mm]eu\s|[Bb]log[s]\s/){
            $counter ++;
        }
    }

    close $news or die "Nao foi possivel abrir o arquivo $news_file_name: $!\n";
}


#A funcao verifica a relacao entre letras maiusculas e letras minusculas no texto. O uso desse fator como metrica e devido ao abuso de caixa alta em fake news para expor tom alarmista.
#Alem disso, blogs utilizam esse artificio para chamar atencao em noticias sobre novelas ou celebridades.
sub check_upper_to_lower_case_ratio{
    #Recebe e abre o arquivo como argumento
    ($news_file_name) = $_[0];
    open (my $news, "<", $news_file_name) or die "Nao foi possivel abrir o arquivo $news_file_name: $!\n";

    my $line;
    my $char_counter = 0;
    my $uppercase_counter = 0;

    while ($line = <$news>){
        while ($line =~ m/\p{Uppercase}/g){
            $uppercase_counter ++;
        }
        $char_counter = $char_counter + length ($line);
    }

    my $upper_to_lower_ratio = $uppercase_counter/$char_counter;

    close $news or die "Nao foi possivel fechar o arquivo $news_file_name: $!\n";  
}

#A funcao procura por palavras de baixo calao no texto. Quando as encontra, o programa as censura, trocando as letras da palavra por *
sub check_curse_words{
    #Recebe e abre o arquivo como argumento
    ($news_file_name, $curse_word_file_name) = @_;
    open (my $news, "<", $news_file_name) or die "Nao foi possivel abrir o arquivo $news_file_name: $!\n";
    open (my $curse_file, "<", $curse_word_file_name) or die "Nao foi possivel abrir o arquivo $curse_word_file_name: $!\n";

    my $news_line;
    

    close $news or die "Nao foi possivel fechar o arquivo $news_file_name: $!\n";
}