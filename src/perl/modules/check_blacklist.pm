
package check_blacklist;

use strict;
use warnings;
use Exporter;
use check_news_format;

our @ISA= qw( Exporter );

# these CAN be exported.
our @EXPORT_OK = qw(check_author_and_source);

# these are exported by default.
our @EXPORT = qw(check_author_and_source);



#Function that verifies if the news author/source is on the blacklist of authors/source. Returns a metric for future evaluation of seriousness'
sub check_author_and_source{

    #Receives news file and author blacklist file
    my $news_file_name = $_[0];
    my $blacklist_file_name = $_[1];
    my $number_lines = $_[2];

    my $returnCheck = check_news_format($news_file_name);
    if ($returnCheck == -1) {
        return -1;
    }

    open (my $news, "<", $news_file_name) or die "ERROR: Could not open file $news_file_name: $!\n";
    open (my $blacklist, "<", $blacklist_file_name) or die "ERROR: Could not open file $blacklist_file_name: $!\n";

    #Reads and discard the first and second line in order to get the author in the third line 
    my $line;
    my $index;
    for ($index = 0; $index < $number_lines; $index++){
        $line = <$news>;
    }
    
    my $line2;
    my $counter = 0;

    #Compares each line from the blacklist with the authors line to verify if author is marked or not
    while ($line2 = <$blacklist>) {
        if ($line =~ /$line2/i ){
            $counter = $counter + 1;
        }
    }


    close $news or die "ERROR: Could not close file $news_file_name: $!\n";
    close $blacklist or die "ERROR: Could not close file $blacklist_file_name: $!\n";

    return $counter;
}

#The comments below were used to test the code
#my $file_test = "arquivo.txt";
#my $blacklist_file = "blacklist.txt";
#my $line_number = 2;
#my $counter = check_author_and_source($file_test, $blacklist_file, 4);
#print $counter,"\n";
