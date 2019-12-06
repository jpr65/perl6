#!/usr/bin/env perl6

use v6;

our sub info (Str $info) {
    say "# --- $info ---";
}

info 'Start';

use Alive::Ticker;

# --- switch on or off ------

# Alive::Ticker::on;
# Alive::Ticker::silent;
# Alive::Ticker::all_off;

# --- create first ticker ---
my Int $ticker = 0;
my $tick = Alive::Ticker::create(
      $ticker,
      smaller      => 10,
      bigger       => 100,
      newline      => 500,
      smaller_char => '+',
      bigger_char  => '#',
      name         => 'M ##',
);

# --- create second ticker ---
my Int $ticker2 = 0;
my $tick2 = Alive::Ticker::create(
      $ticker2,
      smaller      => 10,
      bigger       => 100,
      newline      => 500,
      smaller_char => '*',
      bigger_char  => '&',
      name         => 'Q ##',
      action       => sub (int $c) {
	  say "\nT2 -- $c" if $c % 9983 == 0;
      }
);

# --- run all the tickers and tack -------------

for 1..999 {
    for 1..20 {
	# $tick();
	# $tick2();
    }

    Alive::Ticker::silent if $ticker2 > 6783;
    Alive::Ticker::all_off if $ticker2 > 12142;

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
 
