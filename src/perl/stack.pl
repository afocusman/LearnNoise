#! /usr/bin/env perl
use strict;
use warnings;

#-----------------------------------------------------------------
my $t1   = 0;  # sumstack window
my $t2   = 50;
#-----------------------------------------------------------------
my $dzero;
my $hzero;
my $saclst;
my $depmax;
my $depmin;
my $maximum;

@ARGV == 1 or die "Usage: perl $0 dirname\n";
my ($dir) = @ARGV;

chdir $dir;
open(SAC, "| sac") or die "Error in opening SAC\n";

print SAC "r ft_*.SAC\n";
print SAC "sss\n";
print SAC "tw $t1 $t2\n";
print SAC "ss\n";
print SAC "ws sk_${dzero}${day}.SAC\n";
print SAC "quitsub\n";

=comment
for (my $day = 1; $day <= 29; $day++) {
  if ($day <= 9) { # handle filename order
    $dzero = 0;
  } else {
    $dzero = '';
  }
=comment
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
  }
=cut


  # hourly stack for one day
  print SAC "r ft_*_${dzero}${day}_tr*.SAC\n";
  print SAC "sss\n";
  print SAC "tw $t1 $t2\n";
  print SAC "ss\n";
  print SAC "ws sk_${dzero}${day}.SAC\n";
  print SAC "quitsub\n";

  # normalization amplitude for daily variation
=comment
  my $saclst = `saclst depmin depmax f sk_${dzero}${day}.SAC`;
  ($depmax, $depmin) = (split /\s+/, $saclst)[1,2];
  $maximum = ($depmax + $depmin + abs($depmax - $depmin)) / 2;
  print SAC "r sk_${dzero}${day}.SAC\n";
  print SAC "div $maximum\n";
  print SAC "w over\n";
=cut
}

# daily stack for one month

=comment
print SAC "r sk_*.SAC\n";
print SAC "sss\n";
print SAC "tw $t1 $t2\n";
print SAC "ss\n";
print SAC "ws sk.SAC\n";
print SAC "q\n";
=cut

close(SAC);

chdir "..";
