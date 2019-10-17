package news_subject_classification; 

use strict;
use warnings;



use File::Basename;
use lib dirname (__FILE__);
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
#    foreach (@word_counter) {
#        $metric = $metric + $_ * $weights[$indice];
#        $indice ++;
#    }
    
#    print $metric,"\n"; 
    $metric = $metric/$weight_sum;   
#    print $metric,"\n"; 
    return $metric;
}

#-------------------------------------------------------------------------------------------------------------------


check_politics_subject ("../../news/politics_news.txt");



