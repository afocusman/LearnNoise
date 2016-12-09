#! /usr/bin/env perl
use strict;
use warnings;

#-----------------------------------------------------------------
my $t1   = 0;  # sumstack window
my $t2   = 50;
#-----------------------------------------------------------------

@ARGV == 1 or die "Usage: perl $0 dirname\n";
my ($dir) = @ARGV;

chdir $dir;
open(SAC, "| sac") or die "Error in opening SAC\n";

print SAC "r ft_*.SAC\n";
print SAC "sss\n";
print SAC "tw $t1 $t2\n";
print SAC "ss\n";
print SAC "ws sk.SAC\n";
print SAC "q\n";

close(SAC);

chdir "..";
