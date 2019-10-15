use strict;
use warnings;
use check_news;

use constant CELEBRITY_WEIGHTS => {1,2,3}; #Falta ajeitar


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
sub check_celebrity_sunject{

    #Receives news' file
    $news_file_name = $_[0];
    
    #Checking if the format of the file is right
    my $returnCheck = check_news_format($news_file_name);
    if $returnCheck == -1{
        return -1;
    }
    
    #Trying to open news' file
    open (my $news, "<", $news_file_name) or die "ERROR: Could not open file $news_file_name: $!\n";
    
    my $line;
    my $index;
    my $counter = 0;
    

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";



