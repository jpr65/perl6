#!/usr/bin/env perl6
#==============================================================================
#
#  Test of Alive::Ticker
#
#  Test of totally all off 
#  until restarting - that means recreating the ticker
#  Ralf Peine, Fri Dec  6 13:07:16 2019
#
#==============================================================================

use v6;

use Test;

use Alive::Ticker;

is tacks, 0, 'No tacks before first call';

# --- calling all_off before first tack sets tack complete to "off" ----
ok Alive::Ticker::all_off, 'Alive::Ticker::all_off before first tack';

is tack, 0, 'tack';
is tack, 0, 'tack';
is tack, 0, 'tack';

is tacks, 0, 'called 0 times';

ok Alive::Ticker::silent,  'Alive::Ticker::silent tack is still off';

is tack, 0, 'tack';
is tack, 0, 'tack';
is tack, 0, 'tack';

is tacks, 0, 'called 0 times';

ok Alive::Ticker::silent,  'Alive::Ticker::on tack is still off!';

is tack, 0, 'tack';
is tack, 0, 'tack';
is tack, 0, 'tack';

is tacks, 0, 'called 0 times';

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
