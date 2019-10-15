package check_news

use strict;
use warnings;
use Exporter;

our @ISA= qw( Exporter );

# these CAN be exported.
our @EXPORT_OK = qw(check_news_format);

# these are exported by default.
our @EXPORT = qw( check_news_format );


sub check_news_format{
    
    ($news_file_name) = @_;
    open (my $news, "<", $news_file_name) or die "ERROR: Could not open file $news_file_name: $!\n";

    my $line;
    my $number_lines = 2;
    for ($index = 0; $index < $number_lines; $index++){
        $line = <$news>;
    }
    if (not defined $line || $line eq ""){
        close $news or die "ERROR: Could not close file $news_file_name: $!\n";
        return -1;
    }

    $number_lines = 2;
    for ($index = 0; $index < $number_lines; $index++){
        $line = <$news>;
    }
    if (not defined $line || $line eq ""){
        close $news or die "ERROR: Could not close file $news_file_name: $!\n";
        return -1;
    }

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";
}
