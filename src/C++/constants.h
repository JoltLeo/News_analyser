#ifndef CONSTANTS_H
#define CONSTANTS_H

#define DELIMITER                           "="
#define DELIMITER_LENGTH                    1
#define LESS_SERIOUS                        "-"
#define SERIOUS                             "+"
#define MAXIMUM_FILENAME_LENGTH             50

//Error codes
#define SUCCESS                                     0
#define NEWS_FILE_ERROR                             -1
#define CORRUPTED_FILE                              -2
#define CLASSIFICATION_FILE_ERROR                   -3
#define BLANK_NEWS_FILENAME                         -4
#define BLACKLIST_FILE_ERROR_ADD                    -5
#define BLACKLIST_FILE_ERROR_REMOVE                 -6
#define TEMPORARY_FILE_ERROR_ADD                    -7
#define TEMPORARY_FILE_ERROR_REMOVE                 -8
#define RENAMING_BLACKLIST_ERROR_ADD                -9
#define RENAMING_BLACKLIST_ERROR_REMOVE             -10
#define RENAMING_TEMPORARY_ERROR_ADD                -11
#define RENAMING_TEMPORARY_ERROR_REMOVE             -12
#define NO_AUTHOR_ON_NEWS                           -13
#define WRONG_DATA_FORMAT                           -14
#define NO_SOURCE_ON_NEWS                           -15
#define INCORRECT_INPUT                             -16
#define NOT_CLASSIFY_SERIOUNESS                     -17
#define NOT_CLASSIFY_TYPE                           -18
#define EXCEED_MAXIMUM_SIZE                         -19
#define CLASSIFICATION_FILE_ERROR_ADD               -20
#define CLASSIFICATION_TEMPORARY_FILE_ERROR_ADD     -21
#define RENAMING_CLASSIFICATION_ERROR_ADD           -22
#define RENAMING_TEMPORARY_CLASSIFICATION_ERROR_ADD -23


#endif
