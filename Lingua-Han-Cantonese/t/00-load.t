#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Lingua::Han::Cantonese' );
}

diag( "Testing Lingua::Han::Cantonese $Lingua::Han::Cantonese::VERSION, Perl $], $^X" );
