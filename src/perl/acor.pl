#! /usr/bin/env perl
use strict;
use warnings;

#-----------------------------------------------------------------
my $width  = 0.02; # taper fraction
#-----------------------------------------------------------------
@ARGV == 1 or die "Usage: perl $0 dirname\n";
my ($dir) = @ARGV;

chdir $dir;
open(SAC, "| sac") or die "Error in opening SAC\n";

foreach my $sacfile (glob "sw_*.SAC") {
    print SAC "r $sacfile\n";
    #print SAC "div 1e17\n"; # handle nan
    print SAC "cor\n";
    #print SAC "taper width $width\n";
    print SAC "w ac_${sacfile}\n";
}

print SAC "q\n";
close(SAC);

chdir "..";
