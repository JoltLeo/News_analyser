use strict;
use warnings;

use File::Basename;
use lib dirname (__FILE__) . "/modules";

#My modules
use check_news_format;
use check_artifacts qw(check_superlative check_emoticons check_first_person check_upper_to_lower_case_ratio check_curse_words final_classifier);
use check_blacklist;
use news_subject_classification;
use classify_news;

sub print_menu{
    print "\n---------------------------------------------------------------------------\n";
    print "                             Menu                                          \n";
    print "---------------------------------------------------------------------------\n";
    print "|Type 0 to quit the program                                               |\n";
    print "|Type 1 to check if the author/source is on the blacklist                 |\n";
    print "|Type 2 to classify the subject of the news                               |\n";
    print "|Type 3 to verify if the news has author and date                         |\n";
    print "|Type 4 to count artifacts less serious on the news                       |\n";
    print "|Type 5 to classify if the news is serious or NOT serious                 |\n";
    print "---------------------------------------------------------------------------\n";
}

my $pressed_key;
my $quit_loop = 0;
my $file_name;
my $blacklist_file_name;
my $std_blacklist = "blacklist.txt";
my $curse_words_file_name;
my $return_value;
my @return_values;

while ($quit_loop == 0){
    print_menu();
    print "\nType the desired option and press enter: ";
    $pressed_key = <STDIN>;
    chomp $pressed_key; #Removes \n at the end of the string

    if ($pressed_key lt 6 && $pressed_key gt 0){
        if ($pressed_key eq 1){
            print "\033[2J";    #clear the screen
            print "\033[0;0H";
            print "Enter with the path to the news text file: ";
            $file_name = <STDIN>;
            chomp $file_name;

            print "\nEnter with the path to the blacklist text file. If you wish to use the default blacklist file, press ENTER: ";
            $blacklist_file_name = <STDIN>;
            chomp $blacklist_file_name;

            if ($blacklist_file_name eq ""){
                $return_value = check_author_and_source($file_name, $std_blacklist,2);
                if ($return_value == -1){
                    print "Error executing the function check_author_and_source\n";
                }
                else{
                    print $return_value == 0 ? "\nThe author of the news $file_name is NOT on the blacklist\n":"The author of the news $file_name is on the blacklist\n.";
                }
                $return_value = check_author_and_source($file_name, $std_blacklist,4);
                if ($return_value == -1){
                    print "Error executing the function check_author_and_source\n";
                }
                else{
                    print $return_value == 0 ? "\nThe source of the news $file_name is NOT on the blacklist\n":"The source of the news $file_name is on the blacklist\n.";
                }
                
            } 
            else{
                $return_value = check_author_and_source($file_name, $blacklist_file_name,2);
                if ($return_value == -1){
                    print "Error executing the function check_author_and_source\n";
                }
                else{
                    print $return_value == 0 ? "\nThe author of the news $file_name is NOT on the blacklist\n":"The author of the news $file_name is on the blacklist\n.";
                }
                $return_value = check_author_and_source($file_name, $blacklist_file_name,4);
                if ($return_value == -1){
                    print "Error executing the function check_author_and_source\n";
                }
                else{
                    print $return_value == 0 ? "\nThe source of the news $file_name is NOT on the blacklist\n":"The source of the news $file_name is on the blacklist\n.";
                }
            }
        }
        if ($pressed_key eq 2){
            print "\033[2J";    #clear the screen
            print "\033[0;0H";
            print "\nEnter with the path to the news text file: ";
            $file_name = <STDIN>;
            chomp $file_name;

            my $return_value = classify_subject($file_name);
            if ($return_value eq -1){
                print "Error executing the function classify_subject from news_subject_classification.pm\n";
            }
            else{
                print "\nThe news subject is $return_value\n";
            }
        }
        if ($pressed_key eq 3){
            print "\033[2J";    #clear the screen
            print "\033[0;0H";
            print "\nEnter with the path to the news text file: ";
            $file_name = <STDIN>;
            chomp $file_name;

            $return_value = check_news_format($file_name);
            if ($return_value == -1){
                print "Error executing the function check_author_and_source from check_news_format.pm\n";
            }
            else{
                print "\nThe news text file $file_name is in the right format\n";
            }
        }
        if ($pressed_key eq 4){
            print "\033[2J";    #clear the screen
            print "\033[0;0H";
            print "\nEnter with the path to the news text file: ";
            $file_name = <STDIN>;
            chomp $file_name;
            print "\nEnter with the path to the curse words text file. If you want to use the default curse words, press ENTER: ";
            $curse_words_file_name = <STDIN>;
            chomp $curse_words_file_name;
            if ($curse_words_file_name eq ""){
                @return_values = final_classifier($file_name, "curse_words.txt");
            }
            else {
                @return_values = final_classifier($file_name, $curse_words_file_name);
            }
            if ($return_values[0] == -1){
                print "Error executing the function final_classifier from check_artifacts.pm\n";
            }
            else{
                print "\nThe news $file_name has:\n";
                print "$return_values[0] emoticons;\n";
                print "$return_values[1] first person;\n";
                print "$return_values[2] upper to lower case ratio;\n";
                print "$return_values[3] curse words;\n";
                print "$return_values[4] superlatives.\n";
            }
        }
        if ($pressed_key eq 5){
            print "\033[2J";    #clear the screen
            print "\033[0;0H";
            print "\nEnter with the path to the news text file: ";
            $file_name = <STDIN>;
            chomp $file_name;

            print "\nEnter with the path to the blacklist text file. If you wish to use the default blacklist file, press ENTER: ";
            $blacklist_file_name = <STDIN>;
            chomp $blacklist_file_name;

            print "\nEnter with the path to the curse words text file. If you want to use the default curse words, press ENTER: ";
            $curse_words_file_name = <STDIN>;
            chomp $curse_words_file_name;


            if ($curse_words_file_name eq ""){
                if ($blacklist_file_name eq ""){
                    @return_values = classify_news($file_name);
                }
                else {
                    @return_values = classify_news($file_name, $blacklist_file_name);
                }
            }
            else{
                    @return_values = classify_news($file_name, $blacklist_file_name, $curse_words_file_name);
            }
            if ($return_values[0] < 0){
                print "Error executing function classify_news from classify_news.pm\n";
            }
        }

    }
    elsif ($pressed_key eq 0){
        print "\n---------------------------------------------------------------------------\n";
        print "                             Goodbye!                                      \n";
        print "---------------------------------------------------------------------------\n";
        $quit_loop = 1;
    }
    else{
        print "\n--------------------------------------------------------------------------\n";
        print "  This is not a valid option. Type an option from the menu! ¯\\_(ツ)_/¯   \n";
        print "--------------------------------------------------------------------------\n";
    }
} 
