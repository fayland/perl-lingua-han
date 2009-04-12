# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Lingua-Han2Cantonese.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 5;
BEGIN { use_ok('Lingua::Han::Cantonese') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $h2p = new Lingua::Han::Cantonese();
is(ref($h2p) => 'Lingua::Han::Cantonese', 'class');
my $Cantonese = $h2p->han2Cantonese("ÎÒ");
is($Cantonese, 'ngo', 'correct');
$Cantonese = $h2p->han2Cantonese("°®Äã");
is($Cantonese, 'ngoinei', 'correct');
$Cantonese = $h2p->han2Cantonese("I love ÓàÈğ»ª a");
is($Cantonese, 'i love jyuseoiwaa a', 'correct');