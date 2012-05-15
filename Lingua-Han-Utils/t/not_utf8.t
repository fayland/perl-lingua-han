#!perl -T

use Test::More tests => 3;

use Lingua::Han::Utils qw/Unihan_value/;

my $word = '中';

is(Unihan_value($word), '4E2D', "it's not under utf8");

$word = '喆';

is(Unihan_value($word), '5586', "for gbk Encode::Guess");

$word = "天津山西";
is(Unihan_value($word), '59296D255C71897F', "for multi words");