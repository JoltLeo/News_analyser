package check_news_format;

use strict;
use warnings;
use Exporter;

our @ISA= qw( Exporter );

# these CAN be exported.
our @EXPORT_OK = qw(check_news_format);

# these are exported by default.
our @EXPORT = qw( check_news_format );


sub check_news_format{
    
    my $news_file_name = $_[0];
    open (my $news, "<", $news_file_name) or die "ERROR: Could not open file $news_file_name: $!\n";

    #Verifies if there is at least one author in the news
    my $line;
    my $number_lines = 2;
    my $index;
    for ($index = 0; $index < $number_lines; $index++){
        $line = <$news>;
    }
    chomp $line;
    if ((not defined $line) || ($line eq "") || (length($line) == 0)){
        close $news or die "ERROR: Could not close file $news_file_name: $!\n";
        return -1;
    }

    #Matches date format in the third line of the news
    my $counter = 0;
    $line = <$news>;
    if ($line =~ m/\d\d\/\d\d\/\d\d|\d\/\d\d\/\d\d|\d\/\d\/\d\d|\d\d\/\d\d\/\d\d\d\d|\d\/\d\d\/\d\d\d\d|\d\/\d\/\d\d\d\d/){
        $counter ++;
    }
    if ($line =~ m/\d\d\-\d\d\-\d\d|\d\-\d\d\-\d\d|\d\-\d\-\d\d|\d\d\-\d\d\-\d\d\d\d|\d\-\d\d\-\d\d\d\d|\d\-\d\-\d\d\d\d/){
        $counter ++;
    }
    
    if ($counter == 0){
        close $news or die "ERROR: Could not close file $news_file_name: $!\n";
        return -1;
    }
    
    
    #Verifies if there is a source in the news
    $line = <$news>;
    chomp $line;
  
    if ((not defined $line) || ($line eq "") || (length($line) == 0)){
        close $news or die "ERROR: Could not close file $news_file_name: $!\n";
        return -1;
    }

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";
    return 0;
}

#The commented part below was used for testing the code
#my $news_file = "arquivo.txt";
#my $return_value = check_news_format($news_file);
#print $return_value,"\n";
