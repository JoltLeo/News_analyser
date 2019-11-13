CC=$(shell perl -V::cc:)
CCFLAGS=$(shell perl -MExtUtils::Embed -e ccopts)

LD=$(shell perl -V::ld:)
LDFLAGS=$(shell perl -MExtUtils::Embed -e ldopts)

OBJECTS = 
VERSION=01

all: $(OBJECTS)

perl-ex$(VERSION).o: perl-ex$(VERSION).c
	$(CC) $(CCFLAGS) -o $@ -c $<

perl-ex$(VERSION).o: perl-ex$(VERSION).o
	$(LD) -o $@ $? $(LDFLAGS)




clean:
	rm -f perl-ex$(VERSION)


