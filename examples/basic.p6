#!/usr/bin/env perl6

use v6;

my @months = qw ( Jan Feb Mar Apr Mai Jun Jul Aug Sep Okt Nov Dec );

say join ',', @months[6, 8..11];

# kleiner Fehler: gibt nur 7. Monat aus...
say join ',', @months[6, 8..11]:kv;

say join ',', @months[6]:kv, @months[8..11]:kv;

say join ',', @months[6]:kv;
say join ',', @months[8..11]:kv;


my $month-ref = @months;

my @mm = $month-ref[]; # or .list

say $month-ref[0];
say @mm;

@mm[0] = 'Januar';

say @months;
say @mm;

my @numbers = 100, 200, 300;
my @more_numbers = 500, 600, 700;
my @all_numbers = |@numbers, 400, |@more_numbers;

say @all_numbers;

my $s = 'abcde';
my $t = 'ghi';

say "$t $s";
say $t ~& $s;
say $t ~| $s;
say $t ~^ $s;

say 42 +< 3; # Raku

my @ones = 1 xx 12;
@ones = 5 xx @ones;

say @ones;

sub dostuff() {
    my $value = 2.rand;
    
    return $value > 1 ?? $value !! 0;
}

if dostuff() -> $x { say $x; }
else { say 'nix.'; }
 