use strict;
use warnings;

sub check_emoticons{
    #Receeives news file as argument
    ($news_file_name) = $_[0];
    open (my $news, "<", $news_file_name) or die "ERROR: Could not open file $news_file_name: $!\n";

    # Reads the news file and looks for emoticons 
    my $line;
    my $counter = 0;
    while ($line = <$news>){
        if ($line =~ /[:;][\)D\(\\pO][\s\n!]|[xX][D\\]/){
            $counter ++;
        }
    }

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";

    return ($counter);
}

#The check_first_person function looks for first person patterns in the news file 
sub check_first_person{
    #Receives the news file as arguments
    ($news_file_name) = $_[0];
    open (my $news, "<", $news_file_name) or die "ERROR: Could not open file $news_file_name: $!\n";

    my $line;
    my $counter = 0;
    while ($line = <$news>){
        if ($line =~ /\b[Ee]u\b|\b[Mm]inha\b|\b[Mm]eu\b|\b[Bb]log[s]\b/){
            $counter ++;
        }
    }

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";
}


#The function chek_upper_to_lower_case_ratio calculates the upper to lower case ratio in the news file
sub check_upper_to_lower_case_ratio{
    #Receives the news file as argument
    ($news_file_name) = $_[0];
    open (my $news, "<", $news_file_name) or die "ERROR: Could not open file $news_file_name: $!\n";

    my $line;
    my $char_counter = 0;
    my $uppercase_counter = 0;

    while ($line = <$news>){
        while ($line =~ m/\p{Uppercase}/g){
            $uppercase_counter ++;
        }
        $char_counter = $char_counter + length ($line);
    }

    my $upper_to_lower_ratio = $uppercase_counter/$char_counter;

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";  
}

#The function check_curse_words looks for curse words in the news file text. When it finds it, it replaces the curse word for *censurado*
sub check_curse_words{
    #Receives the news file and the file containing curse words as arguments
    ($news_file_name, $curse_word_file_name) = @_;
    open (my $news, "<", $news_file_name) or die "ERROR: Could not open file $news_file_name: $!\n";
    open (my $curse_file, "<", $curse_word_file_name) or die "ERROR: Could not open file $curse_word_file_name: $!\n";

    my $news_line;
    my $curse_word;
    my $counter = 0;

    while ($curse_word = <$curse_file>){
        while ($news_line = <$news>){
            if ($news_line ~= /$curse_word/){
                $counter ++;
                $news_line =~ s/$curse_word/*censurado*/
            }
        }
    }

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";
}

#The final_classifier metric receives the metrics calculated from the other functions and classifies the news as serious or not
sub final_classifier{
    #Receives the metrics from the other functions to classify the seriousness metric
    ($curse_word_metrics, $upper_case_metrics, $blacklist_metrics, $first_person_metrics, $emoticon_metrics, $news_topic) = @_;

    my $final_metric;

    return $final_metric;

}