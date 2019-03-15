all: anagram.c.bin anagram.rs.bin anagram.cc.bin anagram.d.bin

anagram.cc.bin: anagram.cc
	@time -f "C++ : %E real, %U user, %S sys" clang++ -std=c++14 -O3 -Wall anagram.cc -o anagram.cc.bin

anagram.d.bin: anagram.d
	@time -f "D   : %E real, %U user, %S sys" ldc2 -O3 -release -mcpu=native anagram.d -ofanagram.d.bin
	@rm anagram.d.o

anagram.c.bin: anagram.c
	@time -f "C   : %E real, %U user, %S sys" gcc -Wall -O3 -g anagram.c `pkg-config --libs --cflags glib-2.0` -o anagram.c.bin

anagram.rs.bin: anagram.rs
	@time -f "Rust: %E real, %U user, %S sys" rustc +nightly -C opt-level=3 anagram.rs -o anagram.rs.bin

clean:
	@rm -f anagram.cc.bin anagram.d.bin anagram.c.bin anagram.rs.bin
	@rm -f anagram.cc.txt anagram.d.txt anagram.c.txt anagram.rs.txt anagram.pl.txt anagram.py.txt anagram.p6.txt

WORDS=/usr/share/dict/ngerman
SORT=perl -ne '@x=split/\s/; print join " ",sort(@x),"\n"' | sort
GCOPT="--DRT-gcopt=disable:1"

test_c: all
	@time -f "C:      %E real, %U user, %S sys" ./anagram.c.bin  $(WORDS) | $(SORT) | tee anagram.c.txt  | md5sum

test_cc: all
	@time -f "C++:    %E real, %U user, %S sys" ./anagram.cc.bin $(WORDS) | $(SORT) | tee anagram.cc.txt | md5sum

test_rust: all
	@time -f "Rust:   %E real, %U user, %S sys" ./anagram.rs.bin $(WORDS) | $(SORT) | tee anagram.rs.txt | md5sum

test_d: all
	@time -f "D:      %E real, %U user, %S sys" ./anagram.d.bin  $(GCOPT) $(WORDS) | $(SORT) | tee anagram.d.txt | md5sum

test_py:
	@time -f "Python: %E real, %U user, %S sys" ./anagram.py     $(WORDS) | $(SORT) | tee anagram.py.txt | md5sum

test_pl:
	@time -f "Perl 5: %E real, %U user, %S sys" ./anagram.pl     $(WORDS) | $(SORT) | tee anagram.pl.txt | md5sum

test_p6: # one of these things is not like the others...
	@time -f "Perl 6: %E real, %U user, %S sys" ./anagram.p6     $(WORDS) | $(SORT) | tee anagram.p6.txt | md5sum

test: test_c test_cc test_rust test_d test_py test_pl
