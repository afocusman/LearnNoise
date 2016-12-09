#! /usr/bin/env perl
use strict;
use warnings;

#-----------------------------------------------------------------
my $damp  = 1e-15; # add to denominator to handle divided by zero
#-----------------------------------------------------------------

@ARGV == 1 or die "Usage: perl $0 dirname\n";
my ($dir) = @ARGV;

chdir $dir;
open(SAC, "| sac") or die "Error in opening SAC\n";

foreach my $sacfile (glob "*_tr_*.SAC") {
    print SAC "r $sacfile\n";
    print SAC "abs\n";
    print SAC "add $damp\n"; # handle divided by zero
    print SAC "w abs.SAC\n";
    print SAC "r $sacfile\n";
    print SAC "divf abs.SAC\n";
    print SAC "w ob_${sacfile}\n";
}

print SAC "q\n";
close(SAC);

chdir "..";
