# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Lingua-Han2PinYin.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 3;
BEGIN { use_ok('Lingua::Han::PinYin') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.


my $h2p = new Lingua::Han::PinYin(duoyinzi => 1);
my $pinyin = $h2p->han2pinyin("ÐÐ");
is($pinyin, 'xing hang heng', 'xing/hang');
$h2p2 = new Lingua::Han::PinYin(duoyinzi => 1, tone => 1);
$pinyin = $h2p2->han2pinyin("ÐÐ");
is($pinyin, 'xing2 hang2 xing4 hang4 heng2', 'xing/hang with tone');