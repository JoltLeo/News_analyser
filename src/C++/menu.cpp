#include "menu.h"

using namespace std;


void show_menu()
{
    cout << "\n---------------------------------------------------------------------------\n";
    cout <<  "                             Menu                                          \n" ;
    cout <<  "---------------------------------------------------------------------------\n";
    cout <<  "|Type 0 to quit the program                                               |\n";
    cout <<  "|Type 1 to show a news                                                    |\n";
    cout <<  "|Type 2 to show the title of news classified as less serious              |\n";
    cout <<  "|Type 3 to classify the one or more news in serious or NOT serious        |\n";
    cout <<  "|Type 4 to add/remove an author from the blacklist                        |\n";
    cout <<  "|Type 5 to show a relation of all classified news                         |\n";
    cout <<  "---------------------------------------------------------------------------\n";
    cout <<  "NOTE: this program do not interpret English news, you MUST enter a news text file written in PORTUGUESE when asked!\n";
}

int add_to_classification_file (string news_title, int classification_result)
{
    char temporary_filename [MAXIMUM_FILENAME_LENGTH] = "tmpFile.XXXXXX";
    char swap_filename [MAXIMUM_FILENAME_LENGTH] = "swp.XXXXXX";
  //  char news_classification_filename [MAXIMUM_FILENAME_LENGTH] = "news_classifications.txt";
    int file_descriptor;
    int result;
    string line;
    ifstream classification_file;
    ofstream temporary_file;

    classification_file.open("news_classifications.txt");
    if (!classification_file.is_open()){
        //cout << "ERROR: Could not open classification file" << endl;
        return CLASSIFICATION_FILE_ERROR_ADD;
    } 


    file_descriptor = mkstemp(temporary_filename);
    if (file_descriptor == -1){
        //cout << "ERROR: Could not open temporary file" << endl;
        return CLASSIFICATION_TEMPORARY_FILE_ERROR_ADD; 
    }

    temporary_file.open(temporary_filename);
    if (!temporary_file.is_open()){
        //cout << "ERROR: Could not open temporary file" << endl;
        return CLASSIFICATION_TEMPORARY_FILE_ERROR_ADD;
    }

    while (getline (classification_file, line)){
        temporary_file << line << endl;
    }

    if (classification_result == 0)
    {
        temporary_file << news_title + DELIMITER + SERIOUS;
    }
    else
    {
        temporary_file << news_title + DELIMITER + LESS_SERIOUS;
    }
    
    temporary_file.close();
    classification_file.close();

    file_descriptor = mkstemp(swap_filename);
    if (file_descriptor == -1){
        //cout << "ERROR: Could not open temporary file" << endl;
        return CLASSIFICATION_TEMPORARY_FILE_ERROR_ADD; 
    }

    result = rename ("news_classifications.txt", swap_filename);
    if (result){
        //cout << "Error renaming classification file" << endl;
        remove (temporary_filename);
        return RENAMING_CLASSIFICATION_ERROR_ADD;
    }
    result = rename (temporary_filename, "news_classifications.txt");
    if (result){
        //cout << "Error renaming temporary file" << endl;
        rename (swap_filename, "news_classifications.txt");
        remove (temporary_filename);
        return RENAMING_TEMPORARY_CLASSIFICATION_ERROR_ADD;
    }
    remove(swap_filename);

    return SUCCESS;
}

string Menu::get_news_title (string news_filename)
{
    ifstream file;
    string line;
    string title;

    if (news_filename.length() == 0){
        return "";
    }

    file.open(news_filename);
    if (file.is_open()){
        getline (file, line);
        title = '\"' + line + '\"';
    }else{
        //cout << "Could not open file " << news_filename << endl;
        return "";
	}
	return title;     
}


void Menu::set_input_news_file ()
{
    string line;
    Error_class error_obj;
    cout << "Please, enter the path to the news file or just press enter to use default path: ";
    getline (cin, line);
    if (line.length() > MAXIMUM_FILENAME_LENGTH)
    {
        error_obj.set_code_output (EXCEED_MAXIMUM_SIZE);
        cout << "Using default path" << endl;
        inputs [0] = "noticia.txt";

    }
    else
    {
        if (line == "")
        {
            inputs [0] = "noticia.txt";
        }
        else
        {
            inputs [0] = line;
        }
    }
}

void Menu::set_input_blacklist_file ()
{
    string line;
    Error_class error_obj;
    cout << "Please, enter the path to the blacklist file or just press enter to use default path: ";
    getline (cin, line);
    if (line.length() > MAXIMUM_FILENAME_LENGTH)
    {
        error_obj.set_code_output (EXCEED_MAXIMUM_SIZE);
        cout << "Using default path" << endl;
        inputs [1] = "blacklist.txt";
    }
    else
    {
        if (line == "")
        {
            inputs [1] = "blacklist.txt";
        }
        else
        {
            inputs [1] = line;
        }
    }
}

void Menu::set_input_curse_words_file ()
{
    string line = "";
    Error_class error_obj;
    cout << "Please, enter the path to the curse words file or just press ENTER to use default path: ";
    getline (cin, line);
    if (line.length() > MAXIMUM_FILENAME_LENGTH)
    {
        error_obj.set_code_output (EXCEED_MAXIMUM_SIZE);
        cout << "Using default path" << endl;
        inputs [2] = "curse_words.txt";
    }
    else
    {
        if (line == "")
        {
            inputs [2] = "curse_words.txt";
        }
        else
        {
            inputs [2] = line;
        }
        
    }
}

void Menu::menu_show_news ()
{
    Error_class error_obj;
    int output;
    set_input_news_file ();
    output = show_news (inputs [0]);
    if (output < 0)
    {
        error_obj.set_code_output (output);
        cout << error_obj << endl;
    }
}

void Menu::menu_list_less_serious ()
{
    Error_class error_obj;
    int output;
    output = list_less_serious ("news_classifications.txt");
    if (output < 0)
    {
        error_obj.set_code_output (output);
        cout << error_obj << endl;
    }
}

void Menu::menu_classify_news ()
{
    Error_class error_obj;
    int output;
    string title;
    set_input_news_file ();
    set_input_blacklist_file ();
    set_input_curse_words_file ();
    Perl_wrapper wrapper (inputs[1], inputs[2]);
    output = wrapper.classify_news (inputs[0]);
    if (output < 0)
    {
        error_obj.set_code_output (output);
        cout << error_obj << endl;
    }
    else
    {
        title = get_news_title (inputs[0]);
        if (title == "")
        {
            error_obj.set_code_output (title);
            cout << error_obj << endl;
        }
        else
        {
            output = add_to_classification_file (get_news_title(inputs[0]), output);     
        }
    }
}

void Menu::menu_classification_statistics ()
{
    Error_class error_obj;
    int output;
    output = classification_statistics ("news_classifications.txt");
    if (output < 0)
    {
        error_obj.set_code_output (output);
        cout << error_obj << endl;
    }
}

void Menu::menu_change_blacklist ()
{
    Error_class error_obj;
    int output;
    unsigned control = 0;
    string letter;
    string name;
    set_input_blacklist_file ();
    cout << "Type \"a\" to add an/a author/source to the blacklist file" << endl;
    cout << "Type \"r\" to remove an/a author/source to the blacklist file" << endl; 
    cout << "Type \"e\" to exit" << endl;
    while (control == 0)
    {
        getline(cin, letter);
        switch (letter[0])
        {
            case 'A':
            case 'a':
                cout << "Type the name you want to add to the blacklist: ";
                getline (cin, name);
                output = add_to_blacklist (inputs[1], name);
                if (output < 0)
                {
                    error_obj.set_code_output (output);
                    cout << error_obj << endl;
                }
                control = 1;
                break;

            case 'R':
            case 'r':
                cout << "Type the name you want to remove from the blacklist: ";
                getline (cin, name);
                output = remove_from_blacklist (inputs[1], name);
                if (output < 0)
                {
                    error_obj.set_code_output (output);
                    cout << error_obj << endl;
                }
                control = 1;
                break;

            case 'E':
            case 'e':
                cout << "Exiting" << endl;
                control = 1;
                break;

            default:
                cout << "This option is invalid, type again." << endl;
                cout << "Type \"a\" to add an/a author/source to the blacklist file" << endl;
                cout << "Type \"r\" to remove an/a author/source to the blacklist file" << endl; 
                cout << "Type \"e\" to exit" << endl;
                break;
        }
    }

}
