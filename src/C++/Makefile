CC=g++
CCFLAGS= -std=c++11 `perl -MExtUtils::Embed -e ccopts -e ldopts`

##`perl -MExtUtils::Embed -e ccopts -e ldopts`

LD=g++
LDFLAGS= -std=c++11 `perl -MExtUtils::Embed -e ccopts -e ldopts`



OBJECTS = error_class.o\
          perl_wrapper.o\
	  change_blacklist.o\
	  classification_statistics.o\
	  list_less_serious.o\
	  menu.o\
	  show_news.o\
	  main.o


ALL: news_analyser
		 
all: news_analyser

.cpp.o:
	$(CC) $(CCFLAGS) -c $< 

news_analyser: $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $(OBJECTS)

install: $(OBJECTS)
	make news_analyser


clean:
	rm -f *.o news_analyser
