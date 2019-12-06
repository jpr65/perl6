#!/usr/bin/env perl6
#==============================================================================
#
#  Test of Alive::Ticker
#
#  Test of silent first and then all_off
#
#  Ralf Peine, Fri Dec  6 13:07:16 2019
#
#==============================================================================

use v6;

use Test;

plan 10;

use Alive::Ticker;

is tacks, 0, 'No tacks before first call';

ok Alive::Ticker::silent,  'Alive::Ticker::silent';

ok tack, 'tack';
ok tack, 'tack';
ok tack, 'tack';

is tacks, 3, 'called 3 times';

ok Alive::Ticker::all_off, 'Alive::Ticker::all_off';

ok tack, 'tack';
ok tack, 'tack';

is tacks, 3, 'called 3 times';

done-testing;
