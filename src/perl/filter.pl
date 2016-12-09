#! /usr/bin/env perl
use strict;
use warnings;

#-----------------------------------------------------------------
my $f1      = 0.3; # corner frequency
my $f2      = 0.55;
my $npoles  = 4;   # 1-10, larger --> stricter
my $passes  = 2;   # 1-2
#-----------------------------------------------------------------
@ARGV == 1 or die "Usage: perl $0 dirname\n";
my ($dir) = @ARGV;

chdir $dir;
open(SAC, "| sac") or die "Error in opening SAC\n";

foreach my $sacfile (glob "sw_*.SAC") {
  print SAC "r $sacfile\n";
  print SAC "bp c $f1 $f2 n $npoles p $passes\n";
  print SAC "w ft_$sacfile\n";
}
print SAC "q\n";
close(SAC);

chdir "..";
