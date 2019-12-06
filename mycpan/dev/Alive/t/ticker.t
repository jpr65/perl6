#!/usr/bin/env perl6
#==============================================================================
#
#  Test of Alive::Ticker
#
#  test basics only, using auto configuration
#  tack and tacks in different modes of Ticker
#
#  Ralf Peine, Fri Dec  6 13:07:16 2019
#
#==============================================================================

use v6;

use Test;

use Alive::Ticker;

is tacks, 0, 'No tacks before first call';

ok tack, 'tack';
ok tack, 'tack';

Alive::Ticker::on;

ok tack, 'tack';

is tacks, 3, 'called 3 times';

ok Alive::Ticker::silent,  'Alive::Ticker::silent';

ok tack, 'tack';
is tacks, 4, 'called 4 times but silent';

ok Alive::Ticker::all_off, 'Alive::Ticker::all_off';

ok tack, 'tack';
is tacks, 4, 'called 5th time while off';

done-testing;
