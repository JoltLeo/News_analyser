use strict;
use warnings;
use check_news;


#Function that verifies if the news author/source is on the blacklist of authors/source. Returns a metric for future evaluation of seriousness'
sub check_author_and_source{

    #Receives news file and author blacklist file
    $news_file_name = $_[0];
    $blacklist_file_name = $_[1];
    $number_lines = $_[2];

    my $returnCheck = check_news_format($news_file_name);
    if $returnCheck == -1{
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

    #Verifies how the author is informed in the file
    if ($number_lines == 3){
        if ($line =~ /[Aa]utor:|[Aa]utor\s-/){
            @word = split /:\-/, $line;
            $line = @word[1];
        }
    }

    my $line2;
    my $counter = 0;

    #Compares each line from the blacklist with the authors line to verifie if author is marked or not
    while ($line2 = <$blacklist>) {
        if ($line =~ /$line2/ ){
            $counter = $counter + 1;
        }
    }


    close $news or die "ERROR: Could not close file $news_file_name: $!\n";
    close $blacklist or die "ERROR: Could not close file $blacklist_file_name: $!\n"

    return $counter;
}
