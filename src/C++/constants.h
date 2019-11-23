#ifndef CONSTANTS_H
#define CONSTANTS_H

#define DELIMITER                           "="
#define DELIMITER_LENGTH                    1
#define LESS_SERIOUS                        "-"
#define SERIOUS                             "+"
#define MAXIMUM_FILENAME_LENGTH             50

//Error codes
#define SUCCESS                             0
#define NEWS_FILE_ERROR                     -1
#define CORRUPTED_FILE                      -2
#define CLASSIFICATION_FILE_ERROR           -3
#define BLANK_NEWS_FILENAME                 -4
#define BLACKLIST_FILE_ERROR_ADD            -5
#define BLACKLIST_FILE_ERROR_REMOVE         -6
#define TEMPORARY_FILE_ERROR_ADD            -7
#define TEMPORARY_FILE_ERROR_REMOVE         -8
#define RENAMING_BLACKLIST_ERROR_ADD        -9
#define RENAMING_BLACKLIST_ERROR_REMOVE     -10
#define RENAMING_TEMPORARY_ERROR_ADD        -11
#define RENAMING_TEMPORARY_ERROR_REMOVE     -12

#endif
