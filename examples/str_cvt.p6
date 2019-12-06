#!/usr/bin/env perl6

use v6;

my $char = 'a';
my $num  = $char.ord;
say $num;
my $char2 = $num.chr;
say $char2;
my $copyright = '©';
say $copyright ~ " : " ~ $copyright.ord ~ " : " ~ $copyright.ord.chr;

$char = 'foo';
# ords returns the codepoints of all char in a string
say $char ~ " : " ~ $char.ords;

say "\c[REGISTERED SIGN]";

# POUTING CAT FACE
"\x1f63E".say;
"\x1f63E".uniname.say;