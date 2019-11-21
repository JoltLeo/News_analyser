CC=g++
CCFLAGS=$(shell perl -MExtUtils::Embed -e ldopts)

##`perl -MExtUtils::Embed -e ccopts -e ldopts`

LD=g++
LDFLAGS=$(shell perl -MExtUtils::Embed -e ldopts)

OBJECTS = error_class.o\
          perl_wrapper.o

TESTOBJECTS= error_class.o\
             perl_wrapper.o\
			 test.o


ALL: news_analyser\
	 test
	 
all: news_analyser\
	 test

.cpp.o:
	$(CC) $(CFLAGS) -c $<

news_analyser: $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $(OBJECTS)

test: $(TESTOBJECTS)
	$(LD) $(LDFLAGS) -o $@ $(OBJECTS)


install: $(OBJECTS)


clean:
	rm -f *.o $(ALL)


