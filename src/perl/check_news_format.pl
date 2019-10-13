use strict;
use warnings;

sub check_news_format{
    
    ($news_file_name) = @_;
    open (my $news, "<", $news_file_name) or die "ERROR: Could not open file $news_file_name: $!\n";

    my $line;
    my $number_lines = 2;
    for ($index = 0; $index < $number_lines; $index++){
        $line = <$news>;
    }
    if (not defined $line || $line eq ""){
        exit(1);
    }

    $number_lines = 2;
    for ($index = 0; $index < $number_lines; $index++){
        $line = <$news>;
    }
    if (not defined $line || $line eq ""){
        exit(1);
    }

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";
}