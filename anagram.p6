#!/opt/rakudo-2018.12/bin/perl6
sub MAIN($filename) {
	my %anagram;
	for $filename.IO.slurp.lc.lines -> $line {
		push %anagram{ $line.comb.sort.join }, $line;
	}
	for %anagram.kv -> $k, $v {
		say join(" ", @$v) if (@$v > 1);
	}	
}
