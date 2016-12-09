#! /usr/bin/env perl
use strict;
use warnings;

#-----------------------------------------------------------------
my $T1  = 15; # filter (earthquake band)
my $T2  = 50;
my $halfwidth  = 40; # smooth halfwidth, sample points(1s)
my $damp  = 1e-10; # add to denominator to handle divided by zero
#-----------------------------------------------------------------
my $f1  = 1. / $T2;
my $f2  = 1. / $T1;

@ARGV == 1 or die "Usage: perl $0 dirname\n";
my ($dir) = @ARGV;

chdir $dir;
open(SAC, "| sac") or die "Error in opening SAC\n";

foreach my $sacfile (glob "*_tr_*.SAC") {
    print SAC "r $sacfile\n";
    print SAC "bp c $f1 $f2 n 4 p 2\n"; # temporal normalization using filtered weight to eliminate potential earthquakes
    print SAC "abs\n";
    print SAC "smooth mean h $halfwidth\n";
    print SAC "add $damp\n"; # handle divided by zero
    print SAC "w weight.SAC\n";
    print SAC "r $sacfile\n";
    print SAC "divf weight.SAC\n";
    print SAC "w ra_${sacfile}\n";
}

print SAC "q\n";
close(SAC);

chdir "..";
