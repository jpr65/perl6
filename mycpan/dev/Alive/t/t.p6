#!/usr/bin/env perl6

use v6;

use Alive::Ticker;

my &tick = Alive::Ticker::create(smaller_char => '*', factor => 0);

CATCH { default { say .^name, ' ==> ', .Str }  }
