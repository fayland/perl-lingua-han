# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Lingua-Han2PinYin.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 12;
BEGIN { use_ok('Lingua::Han::PinYin') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.


my $h2p = new Lingua::Han::PinYin(format => 'utf8', tone => 1);
is(ref($h2p) => 'Lingua::Han::PinYin', 'class');
my $pinyin = $h2p->han2pinyin("我");
is($pinyin, 'wo3', 'correct');
$pinyin = $h2p->han2pinyin("少");
is($pinyin, 'shao3', 'correct');
$pinyin = $h2p->han2pinyin("幸");
is($pinyin, 'xing4', 'correct');
$pinyin = $h2p->han2pinyin("爱你");
is($pinyin, 'ai4ni3', 'correct');

$pinyin = $h2p->han2pinyin("呜");
is($pinyin, 'wu1', 'wu1');

$pinyin = $h2p->han2pinyin("迂");
is($pinyin, 'yu1', 'yv1');
$pinyin = $h2p->han2pinyin("驴");
is($pinyin, 'lv2', 'lv2');
$pinyin = $h2p->han2pinyin("女");
is($pinyin, 'nv3', 'women');
$pinyin = $h2p->han2pinyin("绿");
is($pinyin, 'lv4', 'lv4');

$pinyin = $h2p->han2pinyin("中文");
is($pinyin, 'zhong1wen2', 'chinese');
