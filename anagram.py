#!/usr/bin/env python3
import sys
anagram = {}
with open(sys.argv[1], encoding='utf8') as ifs:
    for line in ifs:
        line = line.strip().lower()
        s = ''.join(sorted(line))
        anagram.setdefault(s, []).append(line)
for k, v in anagram.items():
    if len(v) > 1:
        print(" ".join(v))
