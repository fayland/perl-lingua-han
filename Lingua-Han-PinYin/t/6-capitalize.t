# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Lingua-Han2PinYin.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 8;
BEGIN { use_ok('Lingua::Han::PinYin') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $h2p = new Lingua::Han::PinYin(format => 'utf8', capitalize => 1);
is(ref($h2p) => 'Lingua::Han::PinYin', 'class');
my $pinyin = $h2p->han2pinyin("我");
is($pinyin, 'Wo', 'correct');
$pinyin = $h2p->han2pinyin("少");
is($pinyin, 'Shao', 'correct');
$pinyin = $h2p->han2pinyin("幸");
is($pinyin, 'Xing', 'correct');
$pinyin = $h2p->han2pinyin("喆");
is($pinyin, 'Zhe', 'correct');
$pinyin = $h2p->han2pinyin("爱你");
is($pinyin, 'AiNi', 'correct');
$pinyin = $h2p->han2pinyin("钱学森");
is($pinyin, 'QianXueSen', 'correct');
