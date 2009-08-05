# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Lingua-Han2PinYin.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 12;
BEGIN { use_ok('Lingua::Han::PinYin') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.


my $h2p = new Lingua::Han::PinYin();
is(ref($h2p) => 'Lingua::Han::PinYin', 'class');
my $pinyin = $h2p->han2pinyin1("Œ“");
is($pinyin, 'wo', 'correct');
$pinyin = $h2p->han2pinyin1("…Ÿ");
is($pinyin, 'shao', 'correct');
$pinyin = $h2p->han2pinyin1("–“");
#is($pinyin, 'xing', 'correct');

$pinyin = $h2p->han2pinyin("Œ“");
is($pinyin, 'wo', 'correct');
$pinyin = $h2p->han2pinyin("…Ÿ");
is($pinyin, 'shao', 'correct');
$pinyin = $h2p->han2pinyin("–“");
is($pinyin, 'xing', 'correct');

$pinyin = $h2p->han2pinyin("∞Æƒ„");
is($pinyin, 'aini', 'correct');
$pinyin = $h2p->han2pinyin("«Æ—ß…≠");
is($pinyin, 'qianxuesen', 'correct');
$pinyin = $h2p->han2pinyin("I love ”‡»ª™ a");
is($pinyin, 'I love yuruihua a', 'correct');

$pinyin = $h2p->gb2pinyin("∞Æ°™ƒ„°™");
is($pinyin, 'ai°™ni°™', 'correct');
$pinyin = $h2p->gb2pinyin("I love £®∫∫”Ô£©∆¥“Ù Ah");
is($pinyin, 'I love £®hanyu£©pinyin Ah', 'correct');
