import std.stdio, std.algorithm, std.range, std.string;
void main(string[] args) {
	dstring[] [dstring] signs2words;
	foreach(dchar[] w; lines(File(args[1]))) {
		w = w.chomp().toLower();
		signs2words[ w.dup.sort().release().idup ] ~= w.idup;
	}
	foreach (words; signs2words)
		if (words.length > 1)
			writefln(words.join(" "));
}
