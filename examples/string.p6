#!Perl6

my Str $string = 'This Str is holding a String';

say $string;

say '$string is ', $string.^name;

my $scalar = 'Das ist ein Text';

say '$scalar is ', $scalar.^name;

$string = "1" ~ "1" + 10; # 12, 21, or even... "111"?
say $string;

say "1 + 1";

say EVAL "1 + 1";

my $scalarInt = 1234;
say $scalarInt; # 1234
say '$scalarInt is ', $scalarInt.^name;   # $scalar is Int

# literal whitespace
my $squot = '    The quick brown fox jumps over the lazy dog.
	dog.';
my $dquot = "    The quick brown fox jumps over the lazy
	dog.";
say $squot;
say $dquot;

# Double-quotes interpolate special backslash values,
# but single-quotes do not
say 'The quick brown fox\n\tjumps over the lazy dog\n';
say "The quick brown fox\n\tjumps over the lazy dog\n";

# interpolate array elements:
my @animal = ("fox", "dog");
say 'The quick brown @animal[0] jumps over the lazy @animal[1]';
say "The quick brown @animal[0] jumps over the lazy @animal[1]";

# interpolate hash elements:
my %animal = (quick => 'fox', lazy => 'dog');
say 'The quick brown %animal{\'quick\'} jumps over the lazy %animal{\'lazy\'}.';
say "The quick brown %animal{'quick'} jumps over the lazy %animal{'lazy'}.";

# interpolate methods, closures, and functions:
say '@animal.elems() {@animal.elems} &elems(@animal)';
say "@animal.elems() {@animal.elems} &elems(@animal)";
