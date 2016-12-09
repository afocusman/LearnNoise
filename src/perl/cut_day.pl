#! /usr/bin/env perl
#use strict;
use warnings;

my $day;
my $t1;
my $t2;
my $zero;

@ARGV == 1 or die "Usage: perl $0 dirname\n";
my ($dir) = @ARGV;

chdir $dir;
open(SAC, "| sac") or die "Error in opening SAC\n";

foreach my $sacfile (glob "*.SAC") {
  for ($day = 1; $day <= 12; $day++) {
    if ($day <= 9) { # handle filename order
      $zero = 0;
    }
    else {
      $zero = '';
    }

    $t1 = ($day - 1) * 86400;
    $t2 = $t1 + 86400;

    print SAC "cut b $t1 $t2\n";
    print SAC "r $sacfile\n";
    print SAC "rmean; rtr; taper\n";
    print SAC "w ${zero}${day}_${sacfile}\n";
  }
}

print SAC "q\n";
close(SAC);

chdir "..";
