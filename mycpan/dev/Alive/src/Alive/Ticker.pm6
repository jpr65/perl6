#==============================================================================
#
#  Alive::Ticker - Tick-Tack (German baby-word for clock)
#
#  to show perl is still alive and working during long time runnings
#  prints out chars every n-th call 
#
#  Ralf Peine, Thu Dec  5 15:22:54 2019
#
#==============================================================================

unit module Alive::Ticker;

our $VERSION ='0.111';

# === run state ==========================================

# do nothing if off > 0
my int $off = 0;

# --- count and print ---------
our sub on {
    $off = 0;
}

# --- count, but do not print ---------
our sub silent {
    $off = 1;
}

# --- silent for existing instances,            -------
#     new created do nothing, also not counting -------
our sub all_off {
    $off = 2;
}

our proto sub create( | ) {*}

# --- create a new tick tack using $counter given as parameter -----------------
our multi sub create (
    Int $counter  is rw,
    Int :$smaller      where { $smaller > 0 } =  1,
    Int :$bigger       where { $bigger  > 0 } = 10,
    Int :$newline      where { $newline > 0 } = 50,
    Int :$factor       where { $factor  > 0 } = 10,
    Str :$smaller_char = '.',
    Str :$bigger_char  = ',',
    Str :$name         = '',
        :$action
    ) {

    $counter = 0;

    my $name_cnt = $name;
    $name_cnt ~= ' ' if $name_cnt ~~ /\S$/;
    
    return sub { } if $off > 1;
    
    my Int $smaller_cnt = $smaller * $factor;
    my Int $bigger_cnt  = $bigger  * $factor;
    my Int $newline_cnt = $newline * $factor;
    
    return sub {
        return $counter if $off > 1;
        
        $counter++;
        
        if ($action.DEFINITE) {
            $action($counter);
        }
        
        return $counter if $off > 0;
        
        if ($counter % $newline_cnt == 0) {
            print "\n$name_cnt$counter ";
            return $counter;
        }
        
        if ($counter % $bigger_cnt == 0) {
            print $bigger_char;
            return $counter;
        }
        
        if ($counter % $smaller_cnt == 0) {
            print $smaller_char;
            return $counter;
        }

	return $counter;
    }    
}

# --- create a new tick tack ---------------------------------------------------
our multi sub create (
    Int :$smaller      where { $smaller > 0 } =  1,
    Int :$bigger       where { $bigger  > 0 } = 10,
    Int :$newline      where { $newline > 0 } = 50,
    Int :$factor       where { $factor  > 0 } = 10,
    Str :$smaller_char = '.',
    Str :$bigger_char  = ',',
    Str :$name         = '',
        :$action
    ) {

    my Int $hidden_cnt = 0;
    
    return create(
           $hidden_cnt,
    	   smaller      => $smaller       ,
    	   bigger       => $bigger        ,
    	   newline      => $newline       ,
    	   factor       => $factor        ,
    	   smaller_char => $smaller_char  ,
    	   bigger_char  => $bigger_char   ,
    	   name         => $name          ,
           action       => $action        ,
    );
}

# --- default tack ----------------------------------
my $tack;
my Int $tack_counter = 0;

# --- setup default tack ----------------------------
our sub setup (
    Int :$smaller      where { $smaller > 0 } =  1,
    Int :$bigger       where { $bigger  > 0 } = 10,
    Int :$newline      where { $newline > 0 } = 50,
    Int :$factor       where { $factor  > 0 } = 10,
    Str :$smaller_char = '.',
    Str :$bigger_char  = ',',
    Str :$name         = '',
        :$action       
    ) {

    $tack_counter = 0;
    $tack = create(
	$tack_counter,
        smaller      => $smaller      ,
	bigger       => $bigger       ,
	newline      => $newline      ,
	factor       => $factor       ,
	smaller_char => $smaller_char ,
	bigger_char  => $bigger_char  ,
	name         => $name         ,
	action       => $action       ,
    ); 
}

our sub setup-tick-tack (
    Int :$smaller      where { $smaller      > 0 } =  1,
    Int :$bigger       where { $bigger       > 0 } = 10,
    Int :$newline      where { $newline      > 0 } = 50,
    Int :$tick_factor  where { $tick_factor  > 0 } = 10,
    Int :$tack_factor  where { $tack_factor  > 0 } =  1,
    Str :$smaller_char = '*',
    Str :$bigger_char  = '#',
    Str :$tack_name    = '#Tack ',
    Str :$tick_name    = '#Tick ',
        :$action       
    ) is export {

   $tack_counter = 0;
   $tack = create(
	$tack_counter,
        smaller      => $smaller      ,
	bigger       => $bigger       ,
	newline      => $newline      ,
	factor       => $tack_factor  ,
	smaller_char => $smaller_char ,
	bigger_char  => $bigger_char  ,
	name         => $tack_name    ,
	action       => $action       ,
    ); 
   
    my Int $tick_counter = 0;
    return create(
	$tick_counter,
        smaller      => $smaller      ,
	bigger       => $bigger       ,
	newline      => $newline      ,
	factor       => $tick_factor  ,
	smaller_char => '.'           ,
	bigger_char  => ','           ,
	name         => $tick_name    ,
	action       => $action       ,
    ); 
}

# --- return current counter value -----------------------
sub tacks is export {
    return $tack_counter;
}

# === the working function ===============================

# --- count and print default tick tack ------------------
our sub tack is export {
    setup() unless $tack.DEFINITE;
    $tack();
    return $tack_counter;
}

=begin pod

=head1 NAME

Alive::Ticker - to show perl6/raku is still alive and working during long time runnings

=head1 VERSION

This documentation refers to version 0.100 of Alive::Ticker

=head1 SYNOPSIS

Shortest

  use Alive::Ticker qw(tack);
  
  foreach my $i (1..10000) {
      tack;
  }

or fastest

  use Alive::Ticker qw(tack);

  my $tick = tack;
  
  foreach my $i (1..10000) {
      $tick->();
  }

or individual

  my $tick = Alive::Ticker::create(
      -smaller      => 10,
      -bigger       => 100,
      -newline      => 500,
      -smaller_char => '+',
      -bigger_char  => '#',
      -name         => 'M ##',
  );

  foreach my $i (1..100000) {
      $tick->();
  }

=head1 DESCRIPTION

Alive::Ticker does inform the user that perl job or script is still running by printing to console.

The following script

  $| = 1;
  use Alive::Ticker qw(:all);
  
  foreach my $i (1..2000) {
      tack;
  }

prints out this

  .........,.........,.........,.........,.........
  500 .........,.........,.........,.........,.........
  1000 .........,.........,.........,.........,.........
  1500 .........,.........,.........,.........,.........
  2000 

=head2 Methods

=head3 new() does not exist

There is no new(), use create() instead. Reason is, that there are no instances of Alive::Ticker
that could be created.

=head3 create()

Alive::Ticker::create() creates a tick closure (a reference to a anonymous sub) for comfort
and fast calling without method name search and without args. The counter is inside.

Using instances is much more work to implement, slower and not so flexible.

=head4 Parameters

  # name        # default: description
  -smaller      #  1: print every $smaller * $factor call $smaller_char 
  -bigger       # 10: print every $bigger  * $factor call $bigger_char 
  -newline      # 50: print every $newline * $factor call "\n$name$$counter_ref"
  -factor       # 10:
  -smaller_char # '.'
  -bigger_char  # ','
  -name         # '': prepend every new line with it
  -counter_ref  # reference to counter that should be used
  -action       # action will be called by every call of tack; or $tick->();


=head3 setup()

Setup create the default ticker tack with same arguments as in create, except that

  # -counter_ref => ignored
  
will be ignored.

=head3 tack or $tick->()

$tick->() prints out a '.' every 10th call (default), a ',' every 100th call (default) and
starts a new line with number of calls done printed every 500th call (default).

=head3 tacks()

returns the value of the counter used by tack.

=head3 get_tack_counter()

returns a reference to the counter variable used by tack for fast access.

=head2 Running Modes

There are 3 running modes that can be selected:

  Alive::Ticker::on();        # default
  Alive::Ticker::silent();
  Alive::Ticker::all_off();

=head3 on()

Call of

  $tick->(); or tack;
  
prints out what is configured. This is the default.

=head3 silent()

Call of 

  $tick->(); tack;
  
prints out nothing, but does the counting.

=head3 all_off()

If you need speed up, use

  Alive::Ticker::all_off();

Now nothing is printed or counted by all ticks.
Selecting this mode gives you maximum speed without removing $tick->() calls.
  
  my $tick = Alive::Ticker::create();
  
  Alive::Ticker::all_off();

  my $tick_never = Alive::Ticker::create();
  
call of $tick->(); prints out nothing and does not count.

$tick_never has an empty sub which is same as

  my $tick_never = sub {};

This $tick_never will also not print out anything, if

  Alive::Ticker::on();
  
is called to enable ticking.

=head2 Using multiple ticks same time

You can use multiple ticks same time, like in the following example.
tick1 ticks all fetched rows and tick2 only those, which are selected by
given filter. So you can see, if database select is still running or halted.
But start ticking not before more than 40000 rows processed. So don't
log out for small selections.

  use Alive::Ticker;
  
  # Ticks all fetched rows
  my $tick1 = Alive::Ticker::create(
      -factor => 100,
      -name   => '   S',
  );

  my $matches = 0;

  # To tick rows selected by filter
  my $tick2 = Alive::Ticker::create(
      -factor       => 10,
      -smaller_char => '+',
      -bigger_char  => '#',
      -name         => 'M ##',
      -counter_ref  => \$matches,
  );

  Alive::Ticker::silent();

  my @filtered_rows;

  foreach my $i (1..100000) {
      my $row = $sql->fetch_row();
      $tick1->();
      
      if ($filter->($row)) {
          push (@filtered_rows, $row);
          $tick2->();
      }
      
      Alive::Ticker::on() if $i == 40000;
  }
  
  say qq();
  say "$matches rows matched to filter.";
  
It will print out something like:

  .....#....,.........,........+.,.......+..,.........+
     S 45000 .........+,......+...,.....+....,.......+..,.....+....
     S 50000 .....+....,........
  M ## 500 .,......+...,...+......,.....+....
     S 55000 +.........,..+.......,.........,+.........,+.........
     S 60000 .+........,+.........,#.......+..,......+...,..+.......
     S 65000 .........,+.......+..,........+.,....+.....,.+........
     S 70000 .......+..,......#...,........+.,........+.,.........
     S 75000 ..+.......,......+...,....+.....,..+.......,.....+....
     S 80000 ....+.....,.........+,.........,........#.,.......+..
     S 85000 ..+.......,+........+.,.........+,........+.,.........
     S 90000 .......+..,......+...,......+...,...#......,....+.....
     S 95000 +.........,..+.....+..,.........,+.........,.+........+
     S 100000 
  987 rows matched to filter.

=head1 SEE ALSO 

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2015 by Ralf Peine, Germany. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.6.0 or,
at your option, any later version of Perl 5 you may have available.

=head1 DISCLAIMER OF WARRANTY

This library is distributed in the hope that it will be useful,
but without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.

=end pod
