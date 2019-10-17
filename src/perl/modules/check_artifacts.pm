package check_artifacts;

use strict;
use warnings;
use File::Copy;
use Exporter;

our @ISA= qw( Exporter );

# these CAN be exported.
our @EXPORT_OK = qw(check_emoticons check_first_person check_upper_to_lower_case_ratio check_curse_words final_classifier);

# these are exported by default.
our @EXPORT = qw(final_classifier);



sub check_emoticons{
    #Receives news file as argument
    my $news_file_name = $_[0];
    open (my $news, "<:encoding(UTF-8)", $news_file_name) or die "ERROR: Could not open file $news_file_name: $!\n";

    
    my $temporary_emoji = 0;
    my $temporary_emoticon = 0;
    my $emoticon_counter = 0;
    my $emoji_counter = 0;
    my @emoticon_macthes;
    my @emoji_matches;
    my $counter = 0;

    # Reads the news file and looks for emoticons and emojis 
    while (<$news>){
        @emoticon_macthes = $_ =~ m/[:;][\)D\(\\pO][\s\n!]|[xX][D\\]/g;
        @emoji_matches = $_ =~ m/[\N{U+1F601}-\N{U+1F64F}]|[\N{U+2702}-\N{U+27B0}]|[\N{U+1F680}-\N{U+1F6C0}]/g; #Emojis are matched by their unicode

        $temporary_emoticon = scalar(@emoticon_macthes);
        $temporary_emoji = scalar(@emoji_matches);

        $emoticon_counter = $temporary_emoticon + $emoticon_counter;
        $emoji_counter = $temporary_emoji + $emoji_counter;
    }

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";

    $counter = $emoticon_counter + 2*$emoji_counter;

    return ($counter);
}

#The check_first_person function looks for first person patterns in the news file 
sub check_first_person{
    #Receives the news file as arguments
    my $news_file_name = $_[0];
    open (my $news, "<", $news_file_name) or die "ERROR: Could not open file $news_file_name: $!\n";

    my $counter = 0;
    my @matches;
    my $temporary_counter = 0;

    while (<$news>){
        @matches = $_ =~ m/\b[Ee]u\b|\b[Mm]inha\b|\b[Mm]eu\b|\b[Bb]log[s]\b|\b[Nn]ós\b|\b[Aa]\sgente\b/g;
        $temporary_counter = scalar(@matches);
        
        $counter = $temporary_counter + $counter;
    }

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";

    return $counter;
}


#The function chek_upper_to_lower_case_ratio calculates the upper to lower case ratio in the news file
sub check_upper_to_lower_case_ratio{
    #Receives the news file as argument
    my $news_file_name = $_[0];
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

    return $upper_to_lower_ratio;  
}

#The function check_curse_words looks for curse words in the news file text. When it finds it, it replaces the curse word for *censurado*
sub check_curse_words{
    #Receives the news file and the file containing curse words as arguments
    my $news_file_name = $_[0]; 
    my $curse_word_file_name = $_[1];
    my $temporary_news_file_name = "tempFileToCheck";

    open (my $news, "<", $news_file_name) or die "ERROR: Could not open file $news_file_name: $!\n";
    open (my $curse_file, "<", $curse_word_file_name) or die "ERROR: Could not open file $curse_word_file_name: $!\n";
    open (my $temporary_news_file, ">", $temporary_news_file_name) or die "ERROR: Could not open file $temporary_news_file_name: $!\n";

    my $news_line;
    my $curse_word;
    my $counter = 0;
    my $temporary_counter = 0;
    my @matches;

    while ($curse_word = <$curse_file>){
        while ($news_line = <$news>){
            @matches = $news_line =~ /$curse_word/;
            $temporary_counter = scalar(@matches);
            $counter = $counter + $temporary_counter;
            $news_line =~ s/$curse_word/*censurado*/g;
            print $temporary_news_file $news_line;
        }
    }

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";
    close $curse_file or die "ERROR: Could not close file $curse_word_file_name: $!\n";
    close $temporary_news_file or die "ERROR: Could not close file $temporary_news_file: $!\n";

    move($temporary_news_file_name,$news_file_name);

    return $counter;
}

#The check_superlative function counts the use of superlatives (via portuguese superlative ending matching) in the news file
#Inputs: news text file
sub check_superlative{
    my $news_file_name = $_[0];

    open (my $news, "<:encoding(UTF-8)", $news_file_name) or die "ERROR: Could not open file $news_file_name: $!\n";

    my @matches;
    my $temporary_counter = 0;
    my $counter = 0;

    while(<$news>){
        @matches = $_ =~ m/\N{U+00ED}ssimo\s|\N{U+00E9}rrimo\s/g;
        $temporary_counter = scalar(@matches);
        $counter = $temporary_counter + $counter;
    }

    close $news or die "ERROR: Could not close file $news_file_name: $!\n";

    return $counter;
}

#The final_classifier metric receives the metrics calculated from the other functions and classifies the news as serious or not
#Inputs: news text file, curse_words text file
sub final_classifier{
    #Receives the metrics from the other functions to classify the seriousness metrics
     my @inputs = ($_[0], $_[1]); 
     my @results = (check_emoticons($inputs[0]), check_first_person ($inputs[0]), check_upper_to_lower_case_ratio ($inputs[0]), check_curse_words (@inputs), check_superlative ($inputs[0]));

    return @results;
}

#The comments below were used for testing the code

#my $news_name = "test_archive.txt";
#my $counter = check_emoticons($news_name);
#my $counter = check_first_person($news_name);
#my $curse_file_name = "palavroes.txt";
#my $counter = check_curse_words($news_name,$curse_file_name);
#print $counter,"\n";
#my $counter = check_superlative($news_name);
#print $counter, "\n";
