#include <iostream>
#include <string>

#include "menu.h"

using namespace std;


int main ()
{
    Menu menu;
    int options;
    cout << string(100, '\n'); //Clering screen
    show_menu ();
    while ((options = cin.get()) != 0 )
    {
        switch (options)
        {
            case 1:
                cout << "Option 1 choosen" << endl;            
                menu.show_news ();
                break;
        
            case 2:
                cout << "Option 2 choosen" << endl;            
                menu.list_less_serious ();
                break;

            case 3:
                cout << "Option 3 choosen" << endl;            
                menu.classify_news ();
                break;

            case 4:
                cout << "Option 4 choosen" << endl;            
                menu.chance_blacklist ();
                break;

            case 5:
                cout << "Option 5 choosen" << endl;
                menu.classification_statistics ();
                break;

            default:
                cout << "Invalid option, try again" << endl;
                break;
        }
        show_menu ();
    }
    
    cout << "Exiting... Thank you for using our program!" << endl;
    return 0;
}