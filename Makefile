ipasir/sat/minisat220/libipasirminisat220.a:
	$(MAKE) -C ipasir/sat/minisat220 all

ipasir/sat/picosat961/libipasirpicosat961.a:
	$(MAKE) -C ipasir/sat/picosat961/ all

source/ipasir.o:
	dmd -c -of=source/ipasir.o source/ipasir.d

libipasird_minisat.a: source/ipasir.o ipasir/sat/minisat220/libipasirminisat220.a
	cp ipasir/sat/minisat220/libipasirminisat220.a $@
	ar r $@ source/ipasir.o

libipasird_picosat.a: source/ipasir.o ipasir/sat/picosat961/libipasirpicosat961.a
	cp ipasir/sat/picosat961/libipasirpicosat961.a $@
	ar r $@ source/ipasir.o


libipasird_minisat.so: source/ipasir.o ipasir/sat/minisat220/libipasirminisat220.a
	dmd -L-lstdc++ -shared -of$@ $<

libipasird_picosat.so: source/ipasir.o ipasir/sat/picosat961/libipasirpicosat961.a
	dmd -L-lstdc++ -shared -of$@ $<


all: libipasird_minisat.a libipasird_picosat.a libipasird_minisat.so libipasird_picosat.so

test: libipasird_picosat.a
	dmd -L-lstdc++ -unittest libipasird_picosat.a source/unittest.d source/ipasir.d
	./unittest


clean:
	rm -f libipasird_minisat.a libipasird_picosat.a \
	   libipasird_minisat.so libipasird_picosat.so \
	   source/ipasir.o ipasir/sat/minisat220/libipasirminisat220.a \
	   ipasir/sat/minisat220/libipasirminisat220.a
