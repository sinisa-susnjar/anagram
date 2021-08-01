# Anagrams in different programming languages

This started out as a test to see if the new Perl 6 (Raku[do]) would already be
fast enough to be used in a project of mine (spoiler alert: it's not).

After some initial testing, I got curious and widened my language search to D,
Python and Rust and included plain old C for good measure. I was already using
C++ in my project, so I included that as well, just for fun.

The goal of this experiment was to implement the same anagram algorithm in various
languages to compare compile and runtimes, executable sizes and expressivenes.

In terms of raw performance, nothing beats C: runtime, binary size, compile time.
C++ and Rust come somewhat close. The performance of D varies widely depending
on the used compiler, dmd and gdc produce more or less equally slow code, while
ldc2 takes the lead of the D compilers.

In terms of expressivenes (i.e. the shorter and compacter the code, the better),
D is on par with the scripting languages - Perl (5/6), Python and D all only need
10-11 lines of code for the implementation.

Rust and C++ are on par and need three times as much lines of code, while C comes
in last with four times as many lines of code.

The compiled executables differ wildly in size, from a mere 9k for C and 18k for
C++ to 250k for Rust and 1560k for D (ldc2). Winner here is C, followed by C++.

Finally the compile times - C takes the pole position, Rust is second with a six
times longer compile time than C. C++ has a seven times longer compile than C.
D (ldc2) takes the last place with a compile time 13x that of C.

This microbenchmark of course is in no way a true representation of the suitability
of the given languages to be used in real project work. It was more or less just a
funny little experiment, i.e. take the results with a grain of salt.

There were a few noteworthy points during that exercise:
* Python is a lot faster than Perl (what happened? Perl was supposed to be the go-to language for text processing?)
* The compile time of C++ sucks - even for such a trivial program
* Rust made great progress - both in terms of runtime and compile time performance
* Although Perl 6 / Rakudo has made great progress to catch up in terms of performance in recent years and it is a beautyful language, the runtime is still abysmal
* C for the win!

All examples were tested on Ubuntu 18.04, the used compilers / interpreters were:
* C:      gcc 7.3.0 (uses gnome glib GHashTable and GArray)
* C++:    clang++ 7.0.0
* Rust:   rustc 1.35.0-nightly
* D:      ldc2 1.15.0-beta1
* Perl:   v5.26.1
* Python: 3.6.7
* Perl 6: 2018.12 / 6.d

## Runtimes
	C:      0:00.32 real, 0.29 user, 0.02 sys
	C++:    0:00.40 real, 0.34 user, 0.05 sys
	Rust:   0:00.49 real, 0.47 user, 0.02 sys
	D:      0:00.68 real, 0.61 user, 0.06 sys
	Python: 0:00.95 real, 0.89 user, 0.06 sys
	Perl 5: 0:01.59 real, 1.57 user, 0.01 sys
	Perl 6: 0:43.54 real, 43.56 user, 0.12 sys

* 1st: C
* 2nd: C++
* 3rd: Rust
* 4th: D (ldc2)
* 5th: Python
* 6th: Perl 5
* 7th: Perl 6

## Codesize in bytes (after stripping)
	  10216 anagram.c.bin
	  18768 anagram.cc.bin
	 256336 anagram.rs.bin
	1597840 anagram.d.bin

* 1st: C
* 2nd: C++
* 3th: Rust
* 4th: D (ldc2)

## Compile times
	C   : 0:00.13 real, 0.11 user, 0.01 sys
	Rust: 0:00.72 real, 2.61 user, 0.05 sys
	C++ : 0:00.93 real, 0.89 user, 0.04 sys
	D   : 0:02.57 real, 2.48 user, 0.08 sys

* 1st: C
* 2nd: Rust
* 3rd: C++
* 4th: D (ldc2)

## Lines of code
	10 anagram.p6
	11 anagram.d
	11 anagram.pl
	11 anagram.py
	28 anagram.rs
	31 anagram.cc
	43 anagram.c

* 1st: Perl, Python, D
* 2nd: Rust, C++
* 3rd: C

