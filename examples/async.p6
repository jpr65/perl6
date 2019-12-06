#!/usr/bin/env perl6

use v6;

say '# --- main start';

start { sleep 1.5; print "hi" }
await 
      Supply.from-list(<A B C D E F>).throttle: 2, {
      sleep 0.5;
      .print
}

say '';
say '# --- main end';

sleep 1;
