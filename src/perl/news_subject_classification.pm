package news_subject_classification; 

use strict;
use warnings;



use File::Basename;
use lib dirname (__FILE__);
use check_news_format;

use Exporter;

our @ISA= qw( Exporter );

# these CAN be exported.
our @EXPORT_OK = qw(check_celebrity_subject, check_economy_subject, check_politics_subject, check_science_subject, check_sports_subject);

# these are exported by default.
our @EXPORT = qw(check_celebrity_subject, check_economy_subject, check_politics_subject, check_science_subject, check_sports_subject);

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




#Function that evaluate if it is a economy news. Returns a grade from 0 to inf representing the chance of the news' 
#subject be economy.
#Main words: 
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
    #word_counter = (count '', count '', count '', count '', count '', count '', count '', count '', count '')


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




