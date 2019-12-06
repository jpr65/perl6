#!/usr/bin/env perl6

use v6;

class cat {
      my Int $cat_counter = 0;
      has Str $.rufname is rw = '';
      has Str $.sound = 'miau';
      has Bool $!living = True;

      submethod TWEAK() {
          $cat_counter++;
      }

      submethod DESTROY {
          # $!died();
      }

      method is_alive returns Bool {
         return $!living;
      }

      method is_busy returns Bool {
         return 100.rand < 85;
      }

      method died {
          if self.is_alive {
             $cat_counter--;
	  }

	  $!living = False;
      }

      method sounds {
      	  say $.sound;
      }

      method count {
          return $cat_counter;
      } 

      method comes returns Bool {
      	  return False if ! $!living;
      	  return ! $.is_busy;
      }

}

class Norweger {
      also is cat;

      method is_busy returns Bool {
      	 my $busy_value = 100.rand;
	 # say sprintf "%.1f%%", $busy_value;
         return $busy_value < 60; # not so busy like cat
      }
}

class DosenOeffner {
      multi method call (cat $katze) {
      	  say "Come, " ~ $katze.rufname;
      }

      method call_and_wait(cat $katze) returns Bool {
      	  my $call_counter = 0;
	  my $katze_ist_da = False;

          repeat {
	      $call_counter++;
       	      $.call($katze);
	      $katze_ist_da = $katze.comes;
	  } while !$katze_ist_da && $call_counter < 20;
      	  
	  return $katze_ist_da;
      }

}

my cat $katze;

say $katze;
say $katze.WHAT;
say $katze.DEFINITE;

my $do = DosenOeffner.new;

# my cat $mietze will leave { $_.died;  };
{
	my cat $mietze will leave { $_.died;  };
	$mietze = cat.new(rufname => 'Mietze');
	$katze  = Norweger.new(rufname => 'Siiri');

	$do.call_and_wait($mietze);
	$do.call_and_wait($katze);

	say "Number of cats living: " ~ cat.count;
}

say '# After new calling';
say $katze;
say $katze.DEFINITE;

say $katze.VAR.name ~ ' is a ' ~ $katze.^name;

print 'it sounds: ';
$katze.sounds();

$do.call($katze);

$katze.rufname = 'MiezMiez';

say $katze.rufname;
say $do.call_and_wait($katze) ?? "--> ist da." !! "--> kommt nicht...";
say "Number of cats living: " ~ cat.count;

say $katze.^name ~ ' parents ' ~ $katze.^parents.map({ $_.^name }).join(', ');
say 'All methods: ' ~ $katze.^methods>>.name.join(', ');
say $katze.^name ~ ' methods: ' ~ $katze.^methods(:local)>>.name.join(', ');
say $katze.^name ~ ' attributes: ' ~ $katze.^attributes.join(', ');

say "$katze.rufname() died";
$katze.died;

say "Number of cats living: " ~ cat.count;

say "Kommt nicht.... " if ! $do.call_and_wait($katze);
