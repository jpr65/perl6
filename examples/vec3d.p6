#!/usr/bin/env perl6

use v6;

class Vec3D {
    has Int $.x is rw = 0;
    has Int $.y is rw = 0;
    has Int $.z is rw = 0;

    method Add(Vec3D $v2) {
       return Vec3D.new(
           x => $.x + $v2.x,
           y => $.y + $v2.y,
           z => $.z + $v2.z,
       );
    }

    multi method MulKreuz (Vec3D $v2) {
       
       return $.MulKreuz($v2.x, $v2.y, $v2.z);
    }

    multi method MulKreuz (Int $x, Int $y, Int $z) {
       return Vec3D.new(
           x => $!y * $z - $!z * $y,
           y => $!z * $x - $!x * $z,
           z => $!x * $y - $!y * $x,
       );
    }

    multi method Mul (Vec3D $v2) {
       return $!x * $v2.x 
            + $!y * $v2.y
            + $!z * $v2.z;
       ;
    }

    multi method Mul (Int $l) {
       return Vec3D.new(
           x => $!x * $l;
           y => $!y * $l;
           z => $!z * $l;
       );
    }

    method Laenge() {
	my Num $laenge = sqrt(self.Mul(self));
        return $laenge;
    }
}

my $v = Vec3D.new(x => 1, y => 2, z => 3);

say $v;

my $vv = Vec3D.new(x => 6, y => 7, z => 8);

my $vna = $vv.Add($v);
my $va = $vv.Add($v);

say "vna ", $vna;
say "va  ", $va;
say "vv  ", $vv;

$va.Add($v);

say "vna ", $vna;
say "va  ", $va;
say "vv  ", $vv;

my $vkr = $va.MulKreuz($v);

say $vkr;

my $skalarprod = $va.Mul($v);

say "skalarprod = $skalarprod";

say $vna.MulKreuz(1,0,0);
say $vna.MulKreuz(0,1,0);
say $vna.MulKreuz(0,0,1);

my $laenge = $vna.Laenge;
say "laenge          = $laenge";
say "laenge * laenge = {$laenge * $laenge}";
say "vna.Mul(vna)    = {$vna.Mul($vna)}";

say $vna.MulKreuz(1,0,0).Laenge;

say $vna.MulKreuz(0,1,0).Laenge;

say $vna.MulKreuz(0,0,1).Laenge;

my $v1r = Vec3D.new(x => 0, y => 4, z => 0);

say $v1r;
say $v1r.MulKreuz(1,0,0);
say $v1r.MulKreuz(0,1,0);
say $v1r.MulKreuz(0,0,1);
