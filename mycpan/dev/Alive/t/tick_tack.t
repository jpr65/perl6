#!/usr/bin/env perl6
#==============================================================================
#
#  Test of Alive::Ticker
#
#  Creating and using to tickers:
#  tick and tack
#  In real projects, for exmaple
#  - use tick to count parsed files or lines and
#  - use tack to count the hits found
#  Test restart of counters
#
#  Ralf Peine, Fri Dec  6 13:07:16 2019
#
#==============================================================================

use v6;

use Test;

use Alive::Ticker;

# --- shorthand for say newline ---------------
sub saynl { say ''; }

is tacks, 0, 'No tacks before first call';

# --- setup --------------
my &tick = Alive::Ticker::setup-tick-tack(tack_factor => 10);

# --- first running with tacks ----------------
is tack, 1, 'tack';
is tick, 1, 'tick()';

is tacks, 1, 'Tack called one times';

for 1..332 -> $i-tack {
    tack;
    for 1..23 -> $i-tick {
       tick;
    }
}

saynl;
is tacks, 333, 'Tack called 333 times';

for 1..2000 -> $i-tack {
    tack;
    for 1..3 -> $i-tick {
       tick;
    }
}

saynl;
for 1..1000 -> $i-tack {
    tack;
}

saynl;
for 1..2000 -> $i-tick {
    tick;
}

saynl;
is tacks, 3333, 'Tack called 3333 times';

# --- restart ---
&tick = Alive::Ticker::setup-tick-tack();

tick;
tack;

saynl;

is tacks, 1, 'Tack called one times after restart';

# --- restart 2 ---
&tick = Alive::Ticker::setup-tick-tack(
   tack_factor => 2,
   tick_factor => 1,
   newline     => 30,
   tack_name   => '#TA ',
   tick_name   => '#II ',
);

tick;
tack;

saynl;

is tacks, 1, 'Tack called one times after restart 2';

for 1..221 -> $i {
    tick;
    tack;
}

saynl;

is tacks, 222, 'Tack called 222 times';

done-testing;
