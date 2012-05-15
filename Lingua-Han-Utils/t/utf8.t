#!perl -T

use Test::More tests => 6;

use Lingua::Han::Utils qw/Unihan_value csplit csubstr clength/;

my $word = "中";

is(Unihan_value($word), '4E2D', "it's under utf8");

$word = '喆';

is(Unihan_value($word), '5586', "for gbk Encode::Guess");

$word = "天津山西";
is(Unihan_value($word), '59296D255C71897F', "for multi words");

is(join(', ', csplit("我爱你")), "我, 爱, 你", "csplit");
is(join(', ', csubstr("我爱你", 1, 2)), "爱, 你", "csplit");
is(clength("我爱你"), 3, "clength");