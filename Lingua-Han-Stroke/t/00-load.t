#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Lingua::Han::Stroke' );
}

diag( "Testing Lingua::Han::Stroke $Lingua::Han::Stroke::VERSION, Perl $], $^X" );
