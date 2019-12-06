#!/usr/bin/env perl6

use v6;

# my $file_content = "./io.p6".IO.slurp;

# say $file_content;

for "./io.p6".IO.lines -> $line {
    next if $line ~~ /^\#\s+/ ;
    next if $line ~~ / ^ \s* $ / ;
    say $line;
}