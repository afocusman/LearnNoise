#!/usr/bin/env perl
use strict;
use warnings;

@ARGV == 2 or die "Usage: perl $0 dirname delta\n";
my ($dir, $delta) = @ARGV;
chdir $dir;

open(SAC, "|sac") or die "Error in opening sac\n";

foreach (glob "*.SAC") {
    my (undef, $delta0) = split /\s+/, `saclst delta f $_`;
    next if $delta == $delta0;  

    print SAC "r $_ \n";
    # lowpass filter to avoid aliasing
    printf SAC "lp c %f p 2\n", 0.5/$delta if $delta > $delta0;
    print SAC "interpolate delta $delta \n";
	  print SAC "w in_$_\n";
}

print SAC "q\n";
close(SAC);

chdir "..";
