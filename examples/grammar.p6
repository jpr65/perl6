#!Perl6

grammar Parser {
    has Bool $.invalid;

    rule  TOP  { <who> <love> <lang> }
    token who  { I | You | he | she | \S+ <.error> }
    token love { '♥' | love | loves | \S+ <.error> }
    token lang { < Raku Perl Rust Go Python Ruby C# > | \S+ <.error> }

    method error(--> ::?CLASS:D) {
        $!invalid = True;
        self;
    }
}

say Parser.parse: 'I ♥ Raku';
# OUTPUT: ｢I ♥ Raku｣ love => ｢♥｣ lang => ｢Raku｣

say Parser.parse: 'I love Perl';
# OUTPUT: ｢I love Perl｣ love => ｢love｣ lang => ｢Perl｣

say Parser.parse: 'You love C#';
say Parser.parse: 'he loves Go';
say Parser.parse: 'she loves Ruby';

my $/ = Parser.parse: 'she loves Java';

say '<who>  ' ~ ( $<who>.invalid  ?? 'Failed' !! '' );
say '<love> ' ~ ( $<love>.invalid ?? 'Failed' !! '' );
say '<lang> ' ~ ( $<lang>.invalid ?? 'Failed' !! '' );
