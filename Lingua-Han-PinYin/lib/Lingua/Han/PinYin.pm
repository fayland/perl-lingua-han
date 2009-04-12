package Lingua::Han::PinYin;

use strict;
use vars qw($VERSION);
$VERSION = '0.12';

use File::Spec;
use Lingua::Han::Utils qw/Unihan_value/;

sub new {
	my $class = shift;
	my $dir = __FILE__; $dir =~ s/\.pm//o;
	-d $dir or die "Directory $dir nonexistent!";
	my $self = { @_ };
	my %py;
	my $file = File::Spec->catfile($dir, 'Mandarin.dat');
	open(FH, $file)	or die "$file: $!";
	while(<FH>) {
		my ($uni, $py) = split(/\s+/);
		$py{$uni} = $py;
	}
	close(FH);
	$self->{'py'} = \%py;
	return bless $self => $class;
}

sub han2pinyin {
	my ($self, $hanzi) = @_;
	
	my @code = Unihan_value($hanzi);

	my @result;
	foreach my $code (@code) {
		my $value = $self->{'py'}->{$code};
		if (defined $value) {
			$value =~ s/\d//isg unless ($self->{'tone'});
		} else {
			# if it's not a Chinese, return original word
			$value = pack("U*", hex $code);
		}
		push @result, lc $value;
	}
	
	return wantarray ? @result : join('', @result);

}

1;
__END__
=encoding utf8

=head1 NAME

Lingua::Han::PinYin - Retrieve the Mandarin(PinYin) of Chinese character(HanZi).

=head1 SYNOPSIS

  use Lingua::Han::PinYin;
  
  my $h2p = new Lingua::Han::PinYin();
  print $h2p->han2pinyin("我"); # wo
  my @result = $h2p->han2pinyin("爱你"); # @result = ('ai', 'ni');
  
  # we can set the tone up
  my $h2p = new Lingua::Han::PinYin(tone => 1);
  print $h2p->han2pinyin("我"); #wo3
  my @result = $h2p->han2pinyin("爱你"); # @result = ('ai4', 'ni3');
  print $h2p->han2pinyin("林道"); #lin2dao4
  print $h2p->han2pinyin("I love 余瑞华 a"); #i love yuruihua a

=head1 DESCRIPTION

There is a Chinese document @ L<http://www.fayland.org/project/Han-PinYin/>. It tells why and how I write this module.

=head1 RESTRICTIONS

if the character is polyphone(DuoYinZi), we can B<NOT> point out the correct one.

=head1 RETURN VALUE

Usually, it returns its pinyin/spell. It includes more than 20,000 words (from Unicode.org Unihan.txt, version 4.1.0).

if not(I mean it's not a Chinese character), returns the original word;

=head1 OPTION

=over 4

=item tone => 1|0

default is 0. if tone is needed, plz set this to 1.

=back 

=head1 CAVEAT

we convert Ü to V after version 0.06

=head1 SEE ALSO

L<Unicode::Unihan>

=head1 AUTHOR

Fayland, fayland@gmail.com

feel free to contact me.

=head1 COPYRIGHT

Copyright (c) 2005 Fayland All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>