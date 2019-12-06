#!/usr/bin/env perl6

use v6;

my @list_alt = ( 1, 2, 3, 4, 5, 6, 8, 9, 10 );
my @list_neu = ( 1, 2, 4, 5, 6, 7, 10 );

my %vgl;

my $w;

for @list_alt -> $w {
    %vgl{$w} = 'a';
}

for @list_neu -> $w {
    %vgl{$w} ~= 'n';
}
 
for %vgl.keys.sort -> $w {
    my $vergl = %vgl{$w};
    say "$w => $vergl";
    # say "$w => $vergl" if $vergl ne 'an';
}

say "---------------";

for %vgl.values.grep( none 'an' ) -> $w {
    say $w;
}

say "---------------";

for %vgl.values.grep(none / ^.$ / ) -> $w {
    say $w;
}

my %vgl_rev;

say "---------------";

for %vgl.sort(*.key)>>.kv -> ($w, $vergl) {
    my @list;
    if %vgl_rev{$vergl} {
        @list = %vgl_rev{$vergl}.values;
	# say @list;
    }
    else {
    	 say "first $vergl at $w";
    }

    @list.push($w);
    %vgl_rev{$vergl} = @list
}

for %vgl_rev.keys.sort -> $w {
    print "$w => ";
    say %vgl_rev{$w};	
}