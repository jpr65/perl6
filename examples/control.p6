#!/usr/bin/env perl6

use v6;

sub info (Str $info) {
    say "# --- $info ---";
}

for ("abc", "xc5", "def") -> $s {
    info "with and orwith for '$s'";
    with   $s.index("a") { say "Found a at $_" }
    orwith $s.index("b") { say "Found b at $_" }
    orwith $s.index("c") { say "Found c at $_" }
    else                 { say "Didn't find a, b or c" }

}

info 'You may intermix if-based and with-based clauses.';

if 0 { say "No" } orwith Nil { say "No" } orwith 0 { say "Yes" };

info 'without';

my $answer = (Any, True).roll;
say 42 with $answer;
say "undefined answer" without $answer;

info 'fail';

my $thread_result = start {
   try {
       say "start ...";
       my $value = (^10).pick || fail "Zero is unacceptable";
       say "value $value";
       fail "Odd is also not okay" if $value % 2;
   }
   1;
}

say 'result of start {}: ' ~ $thread_result.result();

info 'when';

{
    my $a = 1;
    my $b = True;
    when $a    { say 'a' }; # no output 
    when so $a { say 'so a' }  # a (in "so $a" 'so' coerces $a to Boolean context True 
                            # which matches with Any) 
    when $b    { say 'b' }; # no output (this statement won't be run) 
    say 'Will never be reached!!';
}

info 'gather';

my @a = gather {
    take 1;
    take 5;
    take 42;
}
say join ', ', @a; 

info 'lazy gather';

my @vals = lazy gather {
    take 1;
    say "Produced a value";
    take 2;
}
say @vals[0];
say 'between consumption of two values';
say @vals[1];

info 'gather/take is scoped dynamically';

sub weird(@elems, :$direction = 'forward') {
    my %direction = (
        forward  => sub { take $_ for @elems },
        backward => sub { take $_ for @elems.reverse },
        random   => sub { take $_ for @elems.pick(*) },
    );

    my $action = %direction{$direction} || sub { say "unknown direction $direction"; };

    return gather $action();
}
 
say weird(<a b c>, :direction<backward> );
say weird(<a b c>, :direction<bla> );

info 'emit -> supply';

my $supply = supply {
    emit $_ for "foo", 42, .5;
}
$supply.tap: {
    say "received {.^name} ($_)";
}

info 'given';

my $var = (Any, 21, any <answer lie>).pick;
given $var {
    when 21 { say $_ * 2 }
    when 'lie' { .say }
    default { say 'default' }
}

given 42 { .say; .Numeric; }

given 42 {
    "This says".say;
    $_ == 42 and ( default { "This says, too".say; 43; } );
    "This never says".say;
}

info 'given when {... proceed }';

given 42 {
    when Int { "Int".say; proceed }
    when 43  { 43.say }
    when 42  { 42.say }
    default  { "got change for an existential answer?".say }
}

info 'given when {... succeed }';

given 42 {
    when Int {
        say "Int";
        succeed "Found";
        say "never this!";
    }
    when 42 { say 42 }
    default { say "dunno?" }
}

info 'given as a statement';

.say given "foo";

say sprintf "%s %02i.%02i.%i",
        <Mo Tu We Th Fr Sa Su>[.day-of-week - 1],
        .day,
        .month,
        .year
    given DateTime.now;

info 'loop';

loop (my $ii = 0; $ii < 4; $ii++) {
    say $ii;
}

info 'next';

my Int $i = 0;
while ($i < 10) {
  next if $i % 2 == 0;
 
  say "$i is odd.";
 
  NEXT {
    $i++;
  }
}

info 'react and whenever';

react {
    whenever Supply.interval(1) {
        next if .is-prime;
        say $_;
        done if $_ == 4;
    }
}

info 'Done'
