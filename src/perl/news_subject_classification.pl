use strict;
use warnings;


use File::Basename;
use lib dirname (__FILE__);
use check_news_format;

#use constant CELEBRITY_WEIGHTS => {1,2,3}; #Falta ajeitar


#Classification subjects:
#(i) 'celebrity'
#(ii) 'economy'
#(iii) 'politics'
#(iv) 'science'
#(v) 'sports'
#(vi) '\0' for undefined subject

#Function that evaluate if it is a celebrity news. Returns a grade from 0 to 100 representing the chance of the news' 
#subject be celebrity.
#Main words: 
sub check_celebrity_subject{

    #Receives news' file
    my $news_file_name = $_[0];
    
    #Checking if the format of the file is right
    my $returnCheck = check_news_format( $news_file_name );
    if ($returnCheck == -1) {
        return -1;
    }
    
    #Trying to open news' file
    print $news_file_name, "\n";
    open (my $news, "<:encoding(UTF-8)", $news_file_name) or die "ERROR: Could not open file '$news_file_name': $!\n";
    my $line_counter = 0;
    my $word_counter = 0;

    while (<$news>) {
        my @matches = $_ =~ m/[^A-z]uma{0,1}[^A-z]/g;
        $line_counter = scalar(@matches);
        $word_counter = $word_counter + $line_counter;
    }    

    print $word_counter,"\n";
    close $news or die "ERROR: Could not close file $news_file_name: $!\n";
}


check_celebrity_subject ('../../news/celebrity_news.txt');
