#!/usr/bin/env perl6
#==============================================================================
#
#  Test of Alive::Ticker
#
#  Test of creating different tickers using different variants of "create()"
#
#  Ralf Peine, Fri Dec  6 13:07:16 2019
#
#==============================================================================

use v6;

use Test;

use Alive::Ticker;

sub saynl { say ''; }

is tacks, 0, 'No tacks before first call';

my Int $tick_counter = 0;
my &tick = Alive::Ticker::create($tick_counter, factor => 1);

is $tick_counter, 0, '0 ticks before first call';

tick;
tick;

Alive::Ticker::on;

my &tick1 = Alive::Ticker::create();
my &tick2 = Alive::Ticker::create(factor => 1, smaller_char => '*');
my &tick3 = Alive::Ticker::create(factor => 1);

tick;

saynl;

tick1; # No output, factor is default = 10;
tick2;
tick3;

saynl;

is tacks,         0, 'tack called 0 times';
is $tick_counter, 3, '3 ticks';

ok Alive::Ticker::silent,  'Alive::Ticker::silent';

tick;
tick2;
tick3;

saynl; # --- be prepared, if there is unexpected writing of ticks... 

is $tick_counter, 4, '4 ticks but silent';

ok Alive::Ticker::all_off, 'Alive::Ticker::all_off';

tick;
tack;

tick1;
tick2;
tick3;

saynl; # --- be prepared, if there is unexpected writing of ticks... 

is $tick_counter, 4, 'tick 5th time while off';

is tacks, 0, 'tack called 0 times';

done-testing;
