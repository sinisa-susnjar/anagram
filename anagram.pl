#!/usr/bin/env perl
open(my $ifs, "<:utf8", $ARGV[0]) or die $!;
binmode STDOUT, ":utf8";
my %anagram;
foreach my $line (split "\n", do { local $/; lc(<$ifs>) }) {
	my $sorted = join '', sort split(//, $line);
	push @{$anagram{$sorted}}, $line;
}
foreach my $k (keys %anagram) {
	print join(" ", @{$anagram{$k}}), "\n" if (@{$anagram{$k}} > 1);
}
