#! /usr/bin/env perl
use strict;
use warnings;

my $hzero;
my $saclst;
my $depmax;
my $depmin;
my $maximum;

@ARGV == 1 or die "Usage: perl $0 dirname\n";
my ($dir) = @ARGV;

chdir $dir;
open(SAC, "| sac") or die "Error in opening SAC\n";

for (my $hour = 1; $hour <= 24; $hour++) {
    if ($hour <= 9) { # handle filename order
      $hzero = 0;
    } else {
      $hzero = '';
    }

    # normalize amp
    my $saclst = `saclst depmax depmin f ft_*_${hzero}${hour}_*.SAC`;
    my ($depmax, $depmin) = (split /\s+/, $saclst)[1,2];
    my $maximum = ($depmax + $depmin + abs($depmax - $depmin)) / 2;
    print SAC "r ft_*_${hzero}${hour}_*.SAC\n";
    print SAC "div $maximum\n";
    print SAC "w over\n";
}

print SAC "q\n";
close(SAC);

chdir "..";
