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

for 1..999 {
    for 1..20 {
	$tick();
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

info 'Done'
