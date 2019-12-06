#!/usr/bin/env perl6

use v6;

# --- in Modul ---------------------

module Info {
      our sub pr (Str $info) is export {
          say "# --- $info ---";
      }
}

# --- sub ohne Modul oder Klasse ---

our sub info (Str $info) {
    Info::pr($info);
}

