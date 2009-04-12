#!perl -T

use Test::More tests => 2;

use Lingua::Han::Utils qw/Unihan_value/;

my $word = "中";

is(Unihan_value($word), '4E2D', "it's under utf8");

$word = '喆';

is(Unihan_value($word), '5586', "for gbk Encode::Guess");