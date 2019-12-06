#!/usr/bin/env perl6

# copy dir tree from $src_dir to $dest_dir

use v6;

sub copy_files (Str $src_dir!, Str $dest_dir!) {
    for dir($src_dir).sort -> $src_file {
    	my $dest_file = "$dest_dir/" ~ $src_file.IO.basename;
    	if ($src_file.IO.f) {
	   print ".";
           # say "copy file $src_file -> $dest_file";
	   $src_file.IO.copy($dest_file);
	}
    }

    say " done.";
}

sub copy_tree (Str $src_dir!, Str $dest_dir!) {
    say "cp -R from  $src_dir -> $dest_dir";
    print "  Start ";
    mkdir $dest_dir;
    
    copy_files($src_dir, $dest_dir);

    for dir($src_dir).sort -> $dir {
    	my $dir_name = $dir.IO.basename;
	# say "Test $dir";
    	if ($dir.IO.d) {
	   copy_tree($dir.Str, "$dest_dir/$dir_name");
        }
    }
}

sub MAIN (Str $src_dir!, Str $dest_dir!) {
    if (! $src_dir.IO.d) {
       die "source directory '$src_dir' cannot be found or read!"
    }
    copy_tree($src_dir, $dest_dir);
}

