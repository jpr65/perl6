#!/usr/bin/env perl6

use v6;

my $search_str = @*ARGS[0];
my $dir_name   = @*ARGS[1];

$dir_name   = 'e:/user/rp/perl6/examples' without $dir_name;

my $perl_files_mapping = /\.p.?6$/;
my @perl_files = dir("$dir_name").map(
   { $_ if $_ ~~ $perl_files_mapping
   });

without $search_str {
    say @perl_files.join("\n");
    exit 0;
}

say "# search for <$search_str> in $dir_name";

$search_str = $search_str.lc;

for @perl_files -> $file {
    next unless $file.IO.f;
    for $file.IO.lines.kv -> $n, $line {
        say "$file:$n:$line" if $line.lc ~~ /$search_str/;
    }
}

