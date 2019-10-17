package news_subject_classification; 

use strict;
use warnings;
use check_news_format;

use Exporter;

our @ISA= qw( Exporter );

# these CAN be exported.
our @EXPORT_OK = qw(check_celebrity_subject check_economy_subject check_politics_subject check_science_subject check_sports_subject);

# these are exported by default.
our @EXPORT = qw(check_celebrity_subject check_economy_subject check_politics_subject check_science_subject check_sports_subject);

#Contain functions check_celebrity_subject, check_economy_subject, check_politics_subject, check_science_subject and check_sports_subject

#-------------------------------------------------------------------------------------------------------------------

#Function that evaluate if it is a celebrity news. Returns a grade from 0 to inf representing the chance of the news' 
#subject be celebrity.
#Main words: gente, voc\xea (s) (você(s)), novela, famoso(s)|famosa(s), expectativa, filho(s)| filha(s), !, casamento, festa
sub check_celebrity_subject{

    #Receives news' file
    my $news_file_name = $_[0];
    
    #Checking if the format of the file is right
    my $returnCheck = check_news_format( $news_file_name );
    if ($returnCheck == -1) {
        return -1;
    }
    
    #Trying to open news' file
    open (my $news, "<:encoding(UTF-8)", $news_file_name) or die "ERROR: Could not open file '$news_file_name': $!\n";
    my $line_counter = 0;
    my @word_counter = (0,0,0,0,0,0,0,0,0);
    my @matches;
    #word_counter = (count 'gente', count 'voc\xea(s)', count 'novela', count 'famoso(s)|famosa(s)', count 'expectativa', count 'filho(s)|filha(s)', count '!', count 'casamento', count 'festa')


    while (<$news>) {

        #Searching for the word 'gente'
        @matches = $_ =~ m/^[gG]ente[^A-z]|[^A-z][gG]ente[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[0] = $word_counter[0] + $line_counter;
            #print "$line_counter\t@matches\n";
        }
        
        #Searching for the word 'voc\xea' (você)
        @matches = $_ =~ m/^[vV]oc\xeas{0,1}[^A-z]|[^A-z][vV]oc\xeas{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[1] = $word_counter[1] + $line_counter;
        }

        #Searching for the word 'novela'
        @matches = $_ =~ m/^[nN]ovelas{0,1}[^A-z]|[^A-z][nN]ovelas{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[2] = $word_counter[2] + $line_counter;
        }

        #Searching for the word 'famoso(s)|famosa(s)'
        @matches = $_ =~ m/^[fF]amos[oa]s{0,1}[^A-z]|[^A-z][fF]amos[oa]s{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
           $word_counter[3] = $word_counter[3] + $line_counter;
        }

        #Searching for the word 'expectativa'
        @matches = $_ =~ m/^[eE]xpectativas{0,1}[^A-z]|[^A-z][eE]xpectativas{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[4] = $word_counter[4] + $line_counter;
        }

        #Searching for the word 'filho(s)|filha(s)'
        @matches = $_ =~ m/^[fF]ilh[oa]s{0,1}[^A-z]|[^A-z][fF]ilh[oa]s{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[5] = $word_counter[5] + $line_counter;
        }

        #Searching for the word ''
        @matches = $_ =~ m/!/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[6] = $word_counter[6] + $line_counter;
        }

        #Searching for the word 'casamento'
        @matches = $_ =~ m/^[cC]asamentos{0,1}[^A-z]|[^A-z][cC]asamentos{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[7] = $word_counter[7] + $line_counter;
        }

        #Searching for the word 'festa'
        @matches = $_ =~ m/^[fF]estas{0,1}[^A-z]|[^A-z][fF]estas{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[8] = $word_counter[8] + $line_counter;
        }

    }


#    foreach (@word_counter) {
#        print "$_\t";
#    }    
#    print "\n";

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";

    #Calculating the celebrity grade of the news
    my $indice = 0;
    my @weights = (8,6,1,2,5,7,9,3,4);
    my $weight_sum = 45;
    my $metric = 0;
    foreach (@word_counter) {
        $metric = $metric + $_ * $weights[$indice];
        $indice ++;
    }
    
    $metric = $metric/$weight_sum;   
 
    return $metric;
}

#-------------------------------------------------------------------------------------------------------------------




#Function that evaluate if it is an economy news. Returns a grade from 0 to inf representing the chance of the news' 
#subject be economy.
#Main words: reforma, banco, $/dolar(es), mercado, dinheiro, empresa, economia, tributo(s)/tributária, %/juros
sub check_economy_subject{

    #Receives news' file
    my $news_file_name = $_[0];
    
    #Checking if the format of the file is right
    my $returnCheck = check_news_format( $news_file_name );
    if ($returnCheck == -1) {
        return -1;
    }
    
    #Trying to open news' file
    open (my $news, "<:encoding(UTF-8)", $news_file_name) or die "ERROR: Could not open file '$news_file_name': $!\n";
    my $line_counter = 0;
    my @word_counter = (0,0,0,0,0,0,0,0,0);
    my @matches;
    #word_counter = (count 'reforma', count 'banco', count '$|dolar(es)', count 'mercado', count 'dinheiro', count 'empresa', count 'economia', count 'tributo(s)/tributária', count '%/juros')


    while (<$news>) {

        #Searching for the word 'reforma(s)'
        @matches = $_ =~ m/^[rR]eformas{0,1}[^A-z]|[^A-z][rR]eformas{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[0] = $word_counter[0] + $line_counter;
            #print "$line_counter\t@matches\n";
        }
        
        #Searching for the word 'banco(s)'
        @matches = $_ =~ m/^[bB]ancos{0,1}[^A-z]|[^A-z][bB]ancos{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[1] = $word_counter[1] + $line_counter;
        }

        #Searching for the word '$ | d\xf3lar(es) (dólar(es))'
        @matches = $_ =~ m/^[dD]\xf3lare{0,1}s{0,1}[^A-z]|[^A-z][dD]\xf3lare{0,1}s{0,1}[^A-z]|\$[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[2] = $word_counter[2] + $line_counter;
        }

        #Searching for the word 'mercado'
        @matches = $_ =~ m/^[Mm]ercados{0,1}[^A-z]|[^A-z][mM]ercados{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
           $word_counter[3] = $word_counter[3] + $line_counter;
        }

        #Searching for the word 'dinheiro'
        @matches = $_ =~ m/^[dD]inheiro[^A-z]|[^A-z][dD]inheiro[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[4] = $word_counter[4] + $line_counter;
        }

        #Searching for the word 'empresa'
        @matches = $_ =~ m/^[eE]mpresas{0,1}[^A-z]|[^A-z][eE]mpresas{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[5] = $word_counter[5] + $line_counter;
        }

        #Searching for the word 'economia'
        @matches = $_ =~ m/^[eE]conomia[^A-z]|[^A-z][eE]conomia[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[6] = $word_counter[6] + $line_counter;
        }

        #Searching for the word 'tributo(s)|tribut\xe1rio(a) (tributário(a))'
        @matches = $_ =~ m/^[tT]ributos{0,1}[^A-z]|[^A-z][tT]ributos{0,1}[^A-z]|^[tT]ribut\xe1ri[oa][^A-z]|[^A-z][tT]ribut\xe1ri[oa][^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[7] = $word_counter[7] + $line_counter;
        }

        #Searching for the word '%|juros'
        @matches = $_ =~ m/^[jJ]uros[^A-z]|[^A-z][jJ]uros[^A-z]|\%/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[8] = $word_counter[8] + $line_counter;
        }

    }

#    foreach (@word_counter) {
#        print "$_\t";
#    }    
#    print "\n";

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";

    #Calculating the economy grade of the news
    my $indice = 0;
    my @weights = (9,5,8,4,2,1,3,6,7);
    my $weight_sum = 45;
    my $metric = 0;
    foreach (@word_counter) {
        $metric = $metric + $_ * $weights[$indice];
        $indice ++;
    }
    
    #print $metric,"\n"; 
    $metric = $metric/$weight_sum;   
    #print $metric,"\n"; 
    return $metric;
}

#-------------------------------------------------------------------------------------------------------------------


#Function that evaluate if it is a politics news. Returns a grade from 0 to inf representing the chance of the news' 
#subject be politics.
#Main words: presidente, ministro|minist\xe9rio (ministério), senhor, governo|governador(es|as), supremo, partido|partid\xe1ri(o|a)(s), federal, caso, senado|senador(es|as)
sub check_politics_subject{

    #Receives news' file
    my $news_file_name = $_[0];
    
    #Checking if the format of the file is right
    my $returnCheck = check_news_format( $news_file_name );
    if ($returnCheck == -1) {
        return -1;
    }
    
    #Trying to open news' file
    open (my $news, "<:encoding(UTF-8)", $news_file_name) or die "ERROR: Could not open file '$news_file_name': $!\n";
    my $line_counter = 0;
    my @word_counter = (0,0,0,0,0,0,0,0,0);
    my @matches;
    #word_counter = (count 'presidente', count 'ministro|minist\xe9rio (ministério)', count 'senhor', count 'governo|governador(es|as)', count 'supremo', count 'partido|partid\xe1ri(o|a)(s)', count 'federal', count 'caso', count 'senado|senador(es|as)')


    while (<$news>) {

        #Searching for the word 'presidente(s)'
        @matches = $_ =~ m/^[pP]residentes{0,1}[^A-z]|[^A-z][pP]residentes{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[0] = $word_counter[0] + $line_counter;
            #print "$line_counter\t@matches\n";
        }
        
        #Searching for the word 'ministr(o|a)(s)|minist\xe9rio(s) (ministério(s))'
        @matches = $_ =~ m/^[mM]inistr[oa]s{0,1}[^A-z]|[^A-z][mM]inistr[oa]s{0,1}[^A-z]|^[mM]inistr\xe9rios{0,1}[^A-z]|[^A-z][mM]inistr\xe9rios{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[1] = $word_counter[1] + $line_counter;
        }

        #Searching for the word 'senhor'
        @matches = $_ =~ m/^[sS]enhor[^A-z]|[^A-z][sS]enhor[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[2] = $word_counter[2] + $line_counter;
        }

        #Searching for the word 'governo(s)|governador(es|as)'
        @matches = $_ =~ m/^[gG]overnos{0,1}[^A-z]|[^A-z][gG]overnos{0,1}[^A-z]|^[gG]overnador[ea]{0,1}s{0,1}[^A-z]|[^A-z][gG]overnador[ea]{0,1}s{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
           $word_counter[3] = $word_counter[3] + $line_counter;
        }

        #Searching for the word 'supremo'
        @matches = $_ =~ m/^[sS]upremo[^A-z]|[^A-z][sS]upremo[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[4] = $word_counter[4] + $line_counter;
        }

        #Searching for the word 'partido(s)|partid\xe1ri(o|a)(s)'
        @matches = $_ =~ m/^[pP]artidos{0,1}[^A-z]|[^A-z][pP]artidos{0,1}[^A-z]|^[pP]artid\xe1ri[oa]s{0,1}[^A-z]|[^A-z][pP]artid\xe1ri[oa]s{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[5] = $word_counter[5] + $line_counter;
        }

        #Searching for the word 'federal(is)'
        @matches = $_ =~ m/^[fF]edera[l|i]s{0,1}[^A-z]|[^A-z][fF]edera[l|i]s{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[6] = $word_counter[6] + $line_counter;
        }

        #Searching for the word 'caso(s)'
        @matches = $_ =~ m/^[cC]asos{0,1}[^A-z]|[^A-z][cC]asos{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[7] = $word_counter[7] + $line_counter;
        }

        #Searching for the word 'senado|senador(es|as)'
        @matches = $_ =~ m/^[sS]enador{0,1}[ea]{0,1}s{0,1}[^A-z]|[^A-z][sS]enador{0,1}[ea]{0,1}s{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[8] = $word_counter[8] + $line_counter;
        }

    }

#    foreach (@word_counter) {
#        print "$_\t";
#    }    
#    print "\n";

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";

    #Calculating the politics grade of the news
    my $indice = 0;
    my @weights = (9,8,5,3,2,6,4,7,1);
    my $weight_sum = 45;
    my $metric = 0;
    foreach (@word_counter) {
        $metric = $metric + $_ * $weights[$indice];
        $indice ++;
    }
    
#    print $metric,"\n"; 
    $metric = $metric/$weight_sum;   
#    print $metric,"\n"; 
    return $metric;
}

#-------------------------------------------------------------------------------------------------------------------


#Function that evaluate if it is a science news. Returns a grade from 0 to inf representing the chance of the news' 
#subject be science.
#Main words: tratamento|tratado(s), pesquisa(s)|pesquisador(es|as), universidade, descobr(iu,imos,e...)|descobert(a|o)(s), nobel, pr\xeamio(s) (prémio), tecnologia(s), doen\xe7a (s) (doença), nov(o|a)(s) 
sub check_science_subject{

    #Receives news' file
    my $news_file_name = $_[0];
    
    #Checking if the format of the file is right
    my $returnCheck = check_news_format( $news_file_name );
    if ($returnCheck == -1) {
        return -1;
    }
    
    #Trying to open news' file
    open (my $news, "<:encoding(UTF-8)", $news_file_name) or die "ERROR: Could not open file '$news_file_name': $!\n";
    my $line_counter = 0;
    my @word_counter = (0,0,0,0,0,0,0,0,0);
    my @matches;
    #word_counter = tratamento|tratado(s), pesquisa(s)|pesquisador(es|as), universidade, descobr(iu,imos,e...)|descobert(a|o)(s), nobel, pr\xeamio(s) (prémio), tecnologia(s), doen\xe7a (s) (doença), nov(o|a)(s) 


    while (<$news>) {

        #Searching for the word 'tratamento(s)|tratado(s))'
        @matches = $_ =~ m/^[tT]ratamentos{0,1}[^A-z]|[^A-z][tT]ratamentos{0,1}[^A-z]|^[tT]ratad[ao]s{0,1}[^A-z]|[^A-z][tT]ratad[oa]s{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[0] = $word_counter[0] + $line_counter;
            #print "$line_counter\t@matches\n";
        }
        
        #Searching for the word 'pesquisa(s)|pesquisador(es|a(s))|pesquisar|pesquisad(o|a)(s)'
        @matches = $_ =~ m/^[pP]esquisa[rs]{0,1}[^A-z]|[^A-z][pP]esquisa[rs]{0,1}[^A-z]|^[pP]esquisad[oa]r{0,1}[ea]{0,1}s{0,1}[^A-z]|[^A-z][pP]esquisad[oa]r{0,1}[ea]{0,1}s{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[1] = $word_counter[1] + $line_counter;
        }

        #Searching for the word 'universidade'
        @matches = $_ =~ m/^[uU]niversidades{0,1}[^A-z]|[^A-z][uU]niversidades{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[2] = $word_counter[2] + $line_counter;
        }

        #Searching for the word 'descobr(iu|mos|iram...)|descobert(o|a)(s)'
        @matches = $_ =~ m/^[dD]escobr[a-z]|[^A-z][dD]escobr[a-z]|^[dD]escobert[oa]s{0,1}[^A-z]|[^A-z][dD]escobert[oa]s{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
           $word_counter[3] = $word_counter[3] + $line_counter;
        }

        #Searching for the word 'Nobel'
        @matches = $_ =~ m/^[nN]obel[^A-z]|[^A-z][nN]obel[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[4] = $word_counter[4] + $line_counter;
        }

        #Searching for the word 'pr\xeamio(s)'
        @matches = $_ =~ m/^[pP]r\xeamios{0,1}[^A-z]|[^A-z][pP]r\xeamios{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[5] = $word_counter[5] + $line_counter;
        }

        #Searching for the word 'tecnologia(s)'
        @matches = $_ =~ m/^[tT]ecnologias{0,1}[^A-z]|[^A-z][tT]ecnologias{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[6] = $word_counter[6] + $line_counter;
        }

        #Searching for the word 'doen\xe7a(s)'
        @matches = $_ =~ m/^[dD]oen\xe7as{0,1}[^A-z]|[^A-z][dD]oen\xe7as{0,1}/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[7] = $word_counter[7] + $line_counter;
        }

        #Searching for the word 'nov(o|a)(s)'
        @matches = $_ =~ m/^[nN]ov[oa]s{0,1}[^A-z]|[^A-z][nN]ov[oa]s{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[8] = $word_counter[8] + $line_counter;
        }

    }

#    foreach (@word_counter) {
#        print "$_\t";
#    }    
#    print "\n";

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";

    #Calculating the science grade of the news
    my $indice = 0;
    my @weights = (7,9,6,8,2,5,1,4,3);
    my $weight_sum = 45;
    my $metric = 0;
    foreach (@word_counter) {
        $metric = $metric + $_ * $weights[$indice];
        $indice ++;
    }
    
#    print $metric,"\n"; 
    $metric = $metric/$weight_sum;   
#    print $metric,"\n"; 
    return $metric;
}

#-------------------------------------------------------------------------------------------------------------------



#Function that evaluate if it is a sports news. Returns a grade from 0 to inf representing the chance of the news' 
#subject be sports.
#Main words: mundo|mundia(l|is), primeir(o|a)(s), time(s)|sele\xe7\xe3o (seleção)|sele\xe7\xf5es (seleções), final(s), carreira, atleta(s), jog(o,os,ar,adores...), trein(o,ar,ador,amento...), venc(i,er,eram,emos...)|ganh(ar,ou,amos...)
sub check_sports_subject{

    #Receives news' file
    my $news_file_name = $_[0];
    
    #Checking if the format of the file is right
    my $returnCheck = check_news_format( $news_file_name );
    if ($returnCheck == -1) {
        return -1;
    }
    
    #Trying to open news' file
    open (my $news, "<:encoding(UTF-8)", $news_file_name) or die "ERROR: Could not open file '$news_file_name': $!\n";
    my $line_counter = 0;
    my @word_counter = (0,0,0,0,0,0,0,0,0);
    my @matches;
    #word_counter = mundo|mundia(l|is), primeir(o|a)(s), time(s)|sele\xe7\xe3o (seleção)|sele\xe7\xf5es (seleções), final(izou,ização,s...)|finais, carreira, atleta(s), jog(o,os,ar,adores...), trein(o,ar,ador,amento...), venc(i,er,eram,emos...)|ganh(ar,ou,amos...)


    while (<$news>) {

        #Searching for the word 'mundo|mundia(l|is)'
        @matches = $_ =~ m/^[mM]undo[^A-z]|[^A-z][mM]undo[^A-z]|^[mM]undia[li]s{0,1}[^A-z]|[^A-z][mM]undia[li]s{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[0] = $word_counter[0] + $line_counter;
            #print "$line_counter\t@matches\n";
        }
        
        #Searching for the word 'primeir(o|a)(s)'
        @matches = $_ =~ m/^[pP]rimeir[oa]s{0,1}[^A-z]|[^A-z][pP]rimeir[oa]s{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[1] = $word_counter[1] + $line_counter;
        }

        #Searching for the word 'time(s)|sele\xe7\xe3o (seleção)|sele\xe7\xf5es (seleções)'
        @matches = $_ =~ m/^[tT]imes{0,1}[^A-z]|[^A-z][tT]imes{0,1}[^A-z]|^[sS]ele\xe7\xe3o[^A-z]|[^A-z][sS]ele\xe7\xe3o[^A-z]|^[sS]ele\xe7\xf5es[^A-z]|[^A-z][sS]ele\xe7\xf5es[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[2] = $word_counter[2] + $line_counter;
        }

        #Searching for the word 'final(izou,s,ização...)|finais'
        @matches = $_ =~ m/^[fF]inal[a-z]{0,1}|[fF]inal[a-z]{0,1}|^[fF]inais[^A-z]|[^A-z][fF]inais[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
           $word_counter[3] = $word_counter[3] + $line_counter;
        }

        #Searching for the word 'carreira'
        @matches = $_ =~ m/^[cC]arreira[^A-z]|[^A-z][cC]arreira[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[4] = $word_counter[4] + $line_counter;
        }

        #Searching for the word 'atleta(s)'
        @matches = $_ =~ m/^[aA]tletas{0,1}[^A-z]|[^A-z][aA]tletas{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[5] = $word_counter[5] + $line_counter;
        }

        #Searching for the word 'jog(o,ar,ador...'
        @matches = $_ =~ m/^[jJ]og[a-z]|[^A-z][jJ]og[a-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[6] = $word_counter[6] + $line_counter;
        }

        #Searching for the word 'trein(o,ador,amento...'
        @matches = $_ =~ m/^[tT]rein[a-z]|[^A-z][tT]rein[a-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[7] = $word_counter[7] + $line_counter;
        }

        #Searching for the word 'venc(er,i,emos,eram...)|ganh(a,amos,aram,o...)'
        @matches = $_ =~ m/^[vV]enc[a-z]|[^A-z][vV]enc[a-z]|^[gG]anh[a-z]|[^A-z][gG]anh[a-z]/g;
        $line_counter = scalar(@matches);
        if ($line_counter != 0){
            $word_counter[8] = $word_counter[8] + $line_counter;
        }

    }

#   foreach (@word_counter) {
#        print "$_\t";
#    }    
#    print "\n";

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";

    #Calculating the sports grade of the news
    my $indice = 0;
    my @weights = (8,4,5,1,2,3,9,7,6);
    my $weight_sum = 45;
    my $metric = 0;
    foreach (@word_counter) {
        $metric = $metric + $_ * $weights[$indice];
        $indice ++;
    }
    
#    print $metric,"\n"; 
    $metric = $metric/$weight_sum;   
#    print $metric,"\n"; 
    return $metric;
}

#-------------------------------------------------------------------------------------------------------------------

