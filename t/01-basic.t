use v6;
use Test;
use Stock::Stuff;

my @x1 = 1,2,3,4;
my @x2 = 2,4,6,8;
#say correlate(@x, @x2);
is correlate(@x1, @x2), 1;

done-testing;
