#!/usr/bin/env perl6

use v6;

my $string = "The Magic Words are Squeamish Ossifrage";

# reverse the characters in a scalar

say $string.flip;

# reverse the words in a scalar

say $string.split(" ").reverse.join(" ");
