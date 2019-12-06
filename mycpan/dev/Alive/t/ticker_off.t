#!/usr/bin/env perl6
#==============================================================================
#
#  Test of Alive::Ticker
#
#  Test of all off 
#  and restarting
#  Ralf Peine, Fri Dec  6 13:07:16 2019
#
#==============================================================================

use v6;

use Test;

use Alive::Ticker;

is tacks, 0, 'No tacks before first call';

is tack, 1, 'tack';

# --- calling all_off after first tack ----
ok Alive::Ticker::all_off, 'Alive::Ticker::all_off after first tack';

is tack, 1, 'tack';
is tack, 1, 'tack';
is tack, 1, 'tack';

is tacks, 1, 'called 1 times';

ok Alive::Ticker::silent,  'Alive::Ticker::silent';

is tack, 2, 'tack';
is tack, 3, 'tack';
is tack, 4, 'tack';

is tacks, 4, 'called 4 times';

ok Alive::Ticker::silent,  'Alive::Ticker::on tack';

is tack, 5, 'tack';
is tack, 6, 'tack';
is tack, 7, 'tack';

is tacks, 7, 'called 7 times';

# --- setup --------------
ok Alive::Ticker::setup(), 'Reset tack by setup';

is tack, 1, 'tack 1';
is tack, 2, 'tack 2';
is tack, 3, 'tack 3';

is tacks, 3, 'called 3 times';

# --- setup --------------
ok Alive::Ticker::setup(), 'Reset tack again by setup';

is tack, 1, 'tack 1';
is tack, 2, 'tack 2';
is tack, 3, 'tack 3';

is tacks, 3, 'called 3 times';

done-testing;
