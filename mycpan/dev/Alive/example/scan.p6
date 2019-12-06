#!/usr/bin/env perl6

use v6;

use Alive::Ticker;

Alive::Ticker::setup(factor => 1);

# --- create match ticker ---
my Int $ticker = 0;
my $tick = Alive::Ticker::create(
      $ticker,
      factor       => 1,
      smaller_char => '+',
      bigger_char  => '#',
      name         => 'M ##',
);

for "ticker.p6".IO.lines -> $l {
    if $l ~~ /\#/ {
        $tick();
    }
    else {
        tack;
    }
}

say '';
say "lines                : " ~ ($ticker + tacks());
say "lines containing <#> : $ticker";