#! /usr/bin/env perl
use strict;
use warnings;

#-----------------------------------------------------------------
my $start  = 1; # start month
my $end    = 12; # end month

my $month;
my $zero;  # handle 1~9 month
#-----------------------------------------------------------------

for ($month = $start; $month <= $end; $month++) {
    # handle filename order
    if ($month <= 9) {
      $zero = 0;
    } else {
      $zero = '';
    }

    # write station list
    open(PAR,">st.txt");
    print PAR ("TA V12A * BHZ 2008-${zero}${month}-01T00:00:00 2008-${zero}${month}-28T00:00:00\n");
    close PAR;

    # fetch
    `time FetchData-2016.089 -l st.txt -o V12A2008${zero}${month}.mseed`;
}

chdir "..";
