#!/usr/bin/env perl6
# grep rekursiv mit Perl

use v6;

use Alive::Ticker;

my &tick = Alive::Ticker::setup-tick-tack(tick_factor => 100, 
					  tack_name   => "# Matches " );

my $max_deep  = 10;
my &log_match = sub (Str $message) { say $message };

sub scan_dir (Str $search_string, Str $search_dir, $file_mapping, Int $deep) {
    # say "# scan in $search_dir ... ";
    
    tick;
    scan_files($search_string, $search_dir, $file_mapping);
    scan_sub_dirs($search_string, $search_dir, $file_mapping, $deep);
}

sub scan_sub_dirs (Str $search_string, Str $search_dir, $file_mapping, $deep) {
    return if $deep >= $max_deep;

    my @sub_dirs_to_scan = dir($search_dir).map(
       { $_ if $_.IO.d;
       });

    for @sub_dirs_to_scan -> $sub_dir {
        next if $sub_dir.Str ~~ /\.precomp$/;
        scan_dir($search_string, $sub_dir.Str, $file_mapping, $deep + 1);
    }
}

sub scan_files (Str $search_string, Str $search_dir, $file_mapping) {
    my @files_to_scan    = dir($search_dir).map(
       { $_ if $_ ~~ $file_mapping
       });

    for @files_to_scan -> $file {
    	next unless $file.IO.f;

        tick;

        try {
    	    for $file.IO.lines.kv -> $n, $line {
                tick;
                if $line.lc ~~ /$search_string/ {
		    tack;
		    log_match("$file:$n:$line");
		}
    	    }
        }
    }
}

multi sub format (DateTime $time) {
    return $time.local.yyyy-mm-dd ~ " " ~ $time.local.hh-mm-ss
}

multi sub format (Date $date) {
    return $date.yyyy-mm-dd;
}

sub MAIN (
    Str   $search_arg    = '',
    Str   $dir_name      = 'e:/user/rp/perl6/examples',
    Bool :$count_only    = False,
    Str  :$files_mapping = '.p.?6$',
    Str  :$out_file      = '',
) {

  my regex file_regex {<$files_mapping>};

  if $search_arg eq '' {
    my @perl_files = dir("$dir_name").map(
       { $_ if $_ ~~ &file_regex;
       });

    say @perl_files.join("\n");
    exit 0;
  }

  my $startup_info = "# search for <$search_arg> for files mapping /$files_mapping/ in $dir_name";

  my Bool $use-ticker = True;
  if $count_only {
      &log_match = sub (Str $message) { };
  }
  elsif $out_file eq '' {
      Alive::Ticker::silent;
      $use-ticker = False;
  }
  else {
      my IO::Handle $log_out = open($out_file, :w)
          or die "Could not open $out_file for writing $!\n";
      
      $log_out.say($startup_info);
      $log_out.say("# " ~ format(DateTime.now));
      &log_match = sub (Str $message) { $log_out.say($message); };
  }

  # say "# " ~ format(Date.today);
  say $startup_info; 

  print "# " if $use-ticker;

  scan_dir($search_arg.lc, $dir_name, &file_regex, 0);

  say '' if $use-ticker;
  say '# ' ~ tacks() ~ ' matches found.';
}
