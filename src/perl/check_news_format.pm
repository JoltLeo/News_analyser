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

    my $line;
    my $number_lines = 2;
    my $index;
    for ($index = 0; $index < $number_lines; $index++){
        $line = <$news>;
    }
    if (not defined $line || $line eq ""){
        close $news or die "ERROR: Could not close file $news_file_name: $!\n";
        return -1;
    }

    $line = <$news>;

    my @matches = $line =~ m/\d\d\/\d\d\/\d\d/
    if (not defined $line || $line eq ""){
        close $news or die "ERROR: Could not close file $news_file_name: $!\n";
        return -1;
    }

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";
    return 0;
}
