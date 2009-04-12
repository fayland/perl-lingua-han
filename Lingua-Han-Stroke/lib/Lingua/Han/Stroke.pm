package Lingua::Han::Stroke;

use warnings;
use strict;
use vars qw($VERSION);
$VERSION = '0.06';

use File::Spec;
use Lingua::Han::Utils qw/Unihan_value/;

sub new {
	my $class = shift;
	my $dir = __FILE__; $dir =~ s/\.pm//o;
	-d $dir or die "Directory $dir nonexistent!";
	my $self;
	my %st;
	my $file = File::Spec->catfile($dir, 'Stroke.dat');
	open(FH, $file)	or die "$file: $!";
	while(<FH>) {
		my ($uni, $st) = split(/\s+/);
		$st{$uni} = $st;
	}
	close(FH);
	$self->{'st'} = \%st;
	return bless $self => $class;
}

sub stroke {
	my ($self, $hanzi) = @_;	
	my $code = Unihan_value($hanzi); # got the Unihan field 1
	return $self->{'st'}->{$code};
}
1;
__END__
=encoding utf8

=head1 NAME

Lingua::Han::Stroke - Retrieve the stroke count of Chinese character.

=head1 SYNOPSIS

    use Lingua::Han::Stroke;
    my $stroke = Lingua::Han::Stroke->new();
    
    print $stroke->stroke("Œ“"); # 7

=head1 DESCRIPTION

any difficulty? send me email. :)

=head1 AUTHOR

Fayland Lam, C<< <fayland at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-lingua-han-stroke at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Lingua-Han-Stroke>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Lingua::Han::Stroke

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Lingua-Han-Stroke>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Lingua-Han-Stroke>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Lingua-Han-Stroke>

=item * Search CPAN

L<http://search.cpan.org/dist/Lingua-Han-Stroke>

=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2005 Fayland Lam, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
