CC=g++
CCFLAGS=$(shell perl -MExtUtils::Embed -e ldopts)

##`perl -MExtUtils::Embed -e ccopts -e ldopts`

LD=g++
LDFLAGS=$(shell perl -MExtUtils::Embed -e ldopts)

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
	$(CC) $(CFLAGS) -c $<

news_analyser: $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $(OBJECTS)

install: $(OBJECTS)

clean:
	rm -f *.o $(ALL)


