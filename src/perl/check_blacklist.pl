#A funcao check_author abre o arquivo de noticias e o arquivo com os autores na blacklist e verifica se o autor da noticia esta na blacklist

sub check_author{

    #Recebe o nome do arquivo de noticia e o arquivo com a blacklist como argumento e abre os arquivos
    $news_file_name = $_[0];
    $blacklist_file_name = $_[1];
    $number_lines = $_[2];
    open (my $news, "<", $news_file_name) or die "Nao foi posivel abrir o arquivo de noticias $news_file_name: $!\n";
    open (my $blacklist, "<", $blacklist_file_name) or die "Nao foi possivel abrir o arquivo $blacklist_file_name: $!\n";

    #Lê e descarta a primeira linha para pegar a segunda linha do texto, que contem o nome do autor
    my $line;
    my $index;
    for ($index = 0; $index < $number_lines; $index++){
        $line = <$news>;
    }

    #Verifica como o arquivo informa o nome do autor, i.e, se na segunda linha está o nome do autor ou está 'Autor:' seguido do nome do autor.
    if ($number_lines == 3){
        if ($line =~ /[Aa]utor:/){
            @word = split /:\-/, $line;
            $line = @word[1];
        }
    }

    my $line2;
    my $counter = 0;

    #Compara a as linhas da blacklist com a segunda linha para verificar se o autor esta na lista ou nao
    while ($line2 = <$blacklist>) {
        if ($line =~ /$line2/ ){
            $counter = $counter + 1;
        }
    }


    close $news or die "Nao foi possivel fechar o arquivo $news_file_name: $!\n";
    close $blacklist or die "Nao foi possivel fechar o arquivo $blacklist_file_name: $!\n"

    return $counter;
}