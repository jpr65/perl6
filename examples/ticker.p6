#!/usr/bin/env perl6

use v6;

use Info;

info 'Start';

use Alive::Ticker;

my Int $ticker = 0;

say $ticker;
my $tick = Alive::Ticker::create(
      $ticker,
      smaller      => 10,
      bigger       => 100,
      newline      => 500,
      smaller_char => '+',
      bigger_char  => '#',
      name         => 'M ##',
);

my Int $ticker2 = 0;
my $tick2 = Alive::Ticker::create(
      $ticker2,
      smaller      => 10,
      bigger       => 100,
      newline      => 500,
      smaller_char => '+',
      bigger_char  => '#',
      name         => 'M ##',
      action       => sub (int $c) {
	  say "\nT2 -- $c" if $c % 9983 == 0;
      }
);

for 1..999 {
    for 1..20 {
	$tick();
	$tick2();
    }
    tack;
}
say '------';

info tacks().Str ~ " -- $ticker";

say '------';

$ticker += 19;
$tick();
tack;

say '';

info tacks().Str ~ " -- $ticker";

$tick2();

say '';

info 'Done'
