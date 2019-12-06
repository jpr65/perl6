#!/usr/bin/env perl6

use v6;

my str $s = "abcd";
my Str $s1 = "abcd";

say $s;
say $s1;

my int $i = 123;
my Int $j = 2;

say "$i $j";

say "length('$i') = " ~ $i.Str.chars;
