# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Lingua-Han2PinYin.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 9;
BEGIN { use_ok('Lingua::Han::PinYin') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $h2p = new Lingua::Han::PinYin(format => 'utf8');
is(ref($h2p) => 'Lingua::Han::PinYin', 'class');
my $pinyin = $h2p->han2pinyin("我");
is($pinyin, 'wo', 'correct');
$pinyin = $h2p->han2pinyin("少");
is($pinyin, 'shao', 'correct');
$pinyin = $h2p->han2pinyin("幸");
is($pinyin, 'xing', 'correct');
$pinyin = $h2p->han2pinyin("喆");
is($pinyin, 'zhe', 'correct');
$pinyin = $h2p->han2pinyin("爱你");
is($pinyin, 'aini', 'correct');
$pinyin = $h2p->han2pinyin("钱学森");
is($pinyin, 'qianxuesen', 'correct');
$pinyin = $h2p->han2pinyin("I love 余瑞华 a");
is($pinyin, 'i love yuruihua a', 'correct');