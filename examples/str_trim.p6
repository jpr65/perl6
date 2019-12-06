#!/usr/bin/env perl6

use v6;

my $string = "\t the cat sat on the mat  ";

$string.=trim;

say $string;
say :$string.perl;
