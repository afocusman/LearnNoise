#!/usr/bin/env perl
use strict;
use warnings;
$ENV{SAC_DISPLAY_COPYRIGHT} = 0;

# transfer trapezoidal frequency range
#-----------------------------------------------------------------
my $f1 = 0.01;
my $f2 = 0.02;
my $f3 = 1.5;
my $f4 = 3.0;
#-----------------------------------------------------------------

@ARGV == 1 or die "Usage: perl $0 dirname\n";
my ($dir) = @ARGV;

chdir $dir;

open(SAC, "| sac") or die "Error in opening sac\n";
foreach my $sacfile (glob "*.SAC") {
    #my ($net, $sta, $loc, $chn) = split /\./, $sacfile;
    my ($net, $sta, $loc, $chn) = split /\./, $sacfile;

    # PZ file: SAC_PZs_NET_STA_CHN_LOC_BeginTime_EndTime
    #my @pz = glob "SAC_PZs_${net}_${sta}_${chn}_${loc}_*_*";
    my @pz = glob "SACPZ*";
    die "PZ file error for $sacfile \n" if @pz != 1;

    print SAC "r $sacfile \n";
    #print SAC "trans from evalresp to vel freq $f1 $f2 $f3 $f4\n";
    print SAC "trans from pol s $pz[0] to vel freq $f1 $f2 $f3 $f4\n";
    #print SAC "mul 1.0e9 \n";
    print SAC "w tr_$sacfile\n";
}
print SAC "q\n";
close(SAC);

chdir "..";
