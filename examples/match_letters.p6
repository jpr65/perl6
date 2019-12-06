#!/usr/bin/env perl6

use v6;

my $var = "\c[OGHAM LETTER RUIS]";
if $var ~~ /^<:letter>+$/ {   # or just /^<:L>+$/ or even  /^\w+$/
    say "{$var}  is purely alphabetic";
}