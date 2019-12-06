#!/usr/bin/env perl6

# parsing Arguments

use v6;

sub MAIN (Int $anz!) {

    my @big_primes = grep { .is-prime }, 1_000_000..(1_000_000+$anz);

    say "total {@big_primes.elems}";

    say "relative: " ~ (@big_primes.elems / $anz * 100);

}
