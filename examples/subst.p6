#!/usr/bin/env perl6

use v6;

my $src = "BBC";

(my $dst = $src ) ~~ s/^B/A/;

say :$dst.perl;