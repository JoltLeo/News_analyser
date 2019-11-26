#include <iostream>
#include <string>

#include "menu.h"

using namespace std;


int main ()
{
    Menu menu;
    string options;
    show_menu ();
    getline(cin, options);
    while ( options[0] != '0' )
    {
        switch (options[0])
        {
            case '1':
		cout << string(100, '\n'); //Clering screen
                cout << "Option 1 choosen\n\n" << endl;            
                menu.menu_show_news ();
                break;
        
            case '2':
		cout << string(100, '\n'); //Clering screen
                cout << "Option 2 choosen\n\n" << endl;            
                menu.menu_list_less_serious ();
                break;

            case '3':
		cout << string(100, '\n'); //Clering screen
                cout << "Option 3 choosen\n\n" << endl;            
                menu.menu_classify_news ();
                break;

            case '4':
		cout << string(100, '\n'); //Clering screen
                cout << "Option 4 choosen\n\n" << endl;            
                menu.menu_change_blacklist ();
                break;

            case '5':
		cout << string(100, '\n'); //Clering screen
                cout << "Option 5 choosen\n\n" << endl;
                menu.menu_classification_statistics ();
                break;

            default:
		cout << string(100, '\n'); //Clering screen
                cout << "Invalid option, try again\n\n" << endl;
                break;
        }
        show_menu ();
    	getline(cin, options);
    }
    
    cout << "Exiting... Thank you for using our program!" << endl;
    return 0;
}
