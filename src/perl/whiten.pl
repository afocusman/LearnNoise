#! /usr/bin/env perl
use strict;
use warnings;

# temporarily use the method in Bensen, which is done
# by smooth in frequency domain
#-----------------------------------------------------------------
my $halfwidth  = 40; # smooth spectral halfwidth
#-----------------------------------------------------------------
@ARGV == 1 or die "Usage: perl $0 dirname\n";
my ($dir) = @ARGV;

chdir $dir;
open(SAC, "| sac") or die "Error in opening SAC\n";

foreach my $sacfile (glob "ob_*.SAC") {
    print SAC "r $sacfile\n";
    print SAC "fft\n";
    print SAC "wsp amph\n";
    print SAC "r ${sacfile}.am\n";
    print SAC "smooth mean h $halfwidth\n";
    print SAC "w smooth.am\n";
    print SAC "r ${sacfile}.am\n";
    print SAC "divf smooth.am\n";
    #print SAC "taper\n"; # further specify parameters
    print SAC "w over\n";
    print SAC "rsp ${sacfile}\n";
    print SAC "ifft\n";
    print SAC "w sw_${sacfile}\n";
}

print SAC "q\n";
close(SAC);

chdir "..";
