package Lingua::Han::Utils;

use warnings;
use strict;
use base 'Exporter';
use vars qw/$VERSION @EXPORT_OK/;
$VERSION = '0.10';
@EXPORT_OK = qw/Unihan_value csplit cdecode csubstr clength/;

use Encode;
use Encode::Guess qw/euc-cn/; # XXX? can't explain

sub cdecode {
	my $word = shift;
	my $enc = Encode::Guess->guess($word);
	my $encoding;
	unless (ref($enc)) {
		$encoding = 'cp936'; # use 'cp936' by default
	} else {
		$encoding = $enc->name;
	}
	$word = decode($encoding, $word);
	return $word;
}

sub Unihan_value {
	my $word = shift;
	$word = cdecode($word);
	my @unihan = map { uc sprintf("%x",$_) } unpack ("U*", $word);
	return wantarray?@unihan:(join('', @unihan));
}

sub csplit {
	my $word = shift;
	my $enc = Encode::Guess->guess($word);
	my @return_words;
	my @code = Unihan_value($word);
	foreach my $code (@code) {
		my $value = pack("U*", hex $code);
		$value = encode($enc->name, $value);
		push @return_words, $value if ($value);
	}
	return wantarray?@return_words:(join('', @return_words));
}

sub csubstr {
	my ($word, $offset, $len) = @_;
	my @words = csplit($word);
	$len = scalar @words - $offset unless ($len);
	@words = splice(@words, $offset, $len);
	return wantarray?@words:(join('', @words));
}

sub clength {
	my $word = shift;
	my @words = csplit($word);
	return scalar @words;
}

1;
__END__
=encoding utf8

=head1 NAME

Lingua::Han::Utils - The utility tools of Chinese character(HanZi)

=head1 SYNOPSIS

    use Lingua::Han::Utils qw/Unihan_value csplit cdecode csubstr clength/;
    
    # cdecode
    # the same as decode('cp936', $word) in ASCII editing mode
    #         and decode('utf8', $word) in Unicode editing mode
    my $word = cdecode($word);
    
    # Unihan_value
    # return the first field of Unihan.txt on unicode.org
    my $word = "我";
    my $unihan = Unihan_value($word); # return '6211'
    my $words = "爱你";
    my @unihan = Unihan_value($word); # return (7231, 4F60)
    my $unihan = Unihan_value($word); # return 72314F60
    
    # csplit
    # split the Chinese characters into an array
    my $words = "我爱你";
    my @words = csplit($words); # return ("我", "爱", "你")
    
    # csubstr
    # treat the Chinese characters as one
    # so it's the same as splice(csplit($words), $offset, $length)
    my $words = "我爱你啊";
    my @words = csubstr($words, 1, 2); # return ("爱", "你")
    my @words = csubstr($words, 1); # return ("爱", "你", "啊")
    my $words = csubstr($words, 1, 2); # 爱你
    
    # clength
    # treat the Chinese character as one
    my $words = "我爱你";
    print clength($words); # 3

=head1 EXPORT

Nothing is exported by default.

=head1 EXPORT_OK

=over 4

=item cdecode

use L<Encode::Guess> to decode the character. It behavers like: decode('cp936', $word) under ASCII editing mode and decode('utf8', $word) under Unicode editing mode.

=item Unihan_value

the first field of Unihan.txt is the Unicode scalar value as U+[x]xxxx, we return the [x]xxxx.

=item csplit

split the Chinese characters into an array, English words can be mixed in.

=item csubstr(WORD, OFFSET, LENGTH)

treat the Chinese character as one word, substr it. 

(BE CAFEFUL! it's NOT lvalue, we cann't use csubstr($word, 2, 3) = $REPLACEMENT)

if no LENGTH is specified, substr form OFFSET to END.

=item clength

treat the Chinese character as one word(length 1).

=back

=head1 DOCUMENT

a Chinese version of document can be found @ L<http://www.fayland.org/journal/Lingua-Han-Utils.html>

=head1 AUTHOR

Fayland Lam, C<< <fayland at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-lingua-han-utils at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Lingua-Han-Utils>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Lingua::Han::Utils

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Lingua-Han-Utils>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Lingua-Han-Utils>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Lingua-Han-Utils>

=item * Search CPAN

L<http://search.cpan.org/dist/Lingua-Han-Utils>

=back

=head1 ACKNOWLEDGEMENTS

the wonderful L<Encode::Guess>

=head1 COPYRIGHT & LICENSE

Copyright 2005 Fayland Lam, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
