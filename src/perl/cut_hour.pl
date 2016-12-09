#! /usr/bin/env perl
#use strict;
use warnings;

my $hour;
my $t1;
my $t2;
my $zero;

@ARGV == 1 or die "Usage: perl $0 dirname\n";
my ($dir) = @ARGV;

chdir $dir;
open(SAC, "| sac") or die "Error in opening SAC\n";


#foreach my $sacfile (glob "*_tr_*.SAC") {
foreach my $sacfile (glob "tr_*.SAC") {
  $t1  = 0;
  $t2  = 3600;
  for ($hour = 1; $hour <= 24; $hour++) {
    if ($hour <= 9) { # handle filename order
      $zero = 0;
    }
    else {
      $zero = '';
    }

    print SAC "cut b $t1 $t2\n";
    print SAC "r $sacfile\n";
    print SAC "rmean; rtr; taper\n";
    print SAC "w ${zero}${hour}_${sacfile}\n";

    $t1 = $t2;
    $t2 = $t2 + 3600;
  }
}

print SAC "q\n";
close(SAC);

chdir "..";
