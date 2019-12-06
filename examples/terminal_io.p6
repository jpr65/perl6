#!/usr/bin/env perl6

use v6;

use Info;

info 'Start';

sub read_number_regex() returns int {
    loop {
        my $x = prompt("Enter a number: ");
        redo unless $x ~~ /^\s*\d+\s*$/;
        say "input: $x";
        return $x;
    }
    return 0; # fire exit, will never be reached!
}

sub read_number_by_try() returns int {
    loop {
        my Str $x = prompt("Enter a number: ");
        my int $i;
    
        try {
		redo if $x.chars < 1;
        	
		$i = $x;
        	CATCH {
        	      say "Not an integer number: $x";
        	      redo;
        	}
        }
        say "input: $x";
        return $i;
    }
    return 0; # fire exit, will never be reached!
}

pr 'pr';

info 'redo';

say 'read_number_regex()  = ' ~ read_number_regex();

Info::pr 'read_number_by_try()';

say 'result = ' ~ read_number_by_try().Str;

info 'Done'
