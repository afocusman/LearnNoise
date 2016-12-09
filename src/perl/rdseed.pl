#!/usr/bin/env perl
use strict;
use warnings;

@ARGV == 1 or die "Usage: perl $0 dirname\n";
my ($dir) = @ARGV;

chdir $dir;  

foreach my $seed (glob "*.seed") {
    system "rdseed -pdf @seed";
};

chdir "..";
