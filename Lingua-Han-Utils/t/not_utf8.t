#!perl -T

use Test::More tests => 2;

use Lingua::Han::Utils qw/Unihan_value/;

my $word = 'ЦР';

is(Unihan_value($word), '4E2D', "it's not under utf8");

$word = '†ґ';

is(Unihan_value($word), '5586', "for gbk Encode::Guess");