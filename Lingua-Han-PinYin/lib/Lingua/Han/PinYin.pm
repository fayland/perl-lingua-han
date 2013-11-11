package Lingua::Han::PinYin;

use strict;
use warnings;
our $VERSION = '0.18';

use File::Spec ();
use Lingua::Han::Utils qw/Unihan_value/;

sub new {
    my $class = shift;

    my $dir   = __FILE__;
    $dir =~ s/\.pm//o;
    -d $dir or die "Directory $dir does not exists, please consider to reinstall this module.";

    my %args = (@_ % 2 == 1) ? %{ $_[0] } : (@_);

    my %py;
    my $file = File::Spec->catfile( $dir, 'Mandarin.dat' );
    open(my $fh, '<', $file) or die "Can't open $file: $!";
    while (my $line = <$fh>) {
        chomp($line);
        my ( $uni, $py ) = split(/\s+/, $line);
        $py{$uni} = $py;
    }
    close($fh);

    $args{'py'} = \%py;

    return bless \%args => $class;
}

sub han2pinyin1 {
    my ($self, $word) = @_;
    my $code = Unihan_value($word);
    my $value = $self->{'py'}->{$code};
    if (defined $value) {
        $value = $self->_fix_val( $value );
    } else {
        # not found in dictionary, return original word
        $value = $word;
    }
    return $value;
}

sub han2pinyin {
    my ( $self, $hanzi ) = @_;

    my @code = Unihan_value($hanzi);

    my @result;
    foreach my $code (@code) {
        my $value = $self->{'py'}->{$code};
        if ( defined $value ) {
            $value = $self->_fix_val( $value );
        }
        else {
            # if it's not a Chinese, return original word
            $value = pack( "U*", hex $code );
        }
        push @result, $value;
    }

    return wantarray ? @result : join( '', @result );

}

sub gb2pinyin {
    my ($self, $hanzi) = @_;

    # convert only normal Chinese letter. Ignore Chinese symbols
    # which fall within [0xa1,0xb0) region. 0xb0==0260
    # if it is not normal Chinese, retain original characters
    $hanzi =~ s/[\260-\377][\200-\377]/$self->han2pinyin1($&)/ge;
    return $hanzi;
}

sub _fix_val {
    my ( $self, $value ) = @_;

    if ($self->{unicode}) {
        return $value;
    }

    # convert into ascii
    $value =~ s/ū/u/g and $value .= '1';
    $value =~ s/ī/i/g and $value .= '1';
    $value =~ s/ō/o/g and $value .= '1';
    $value =~ s/ā/a/g and $value .= '1';
    $value =~ s/ē/e/g and $value .= '1';

    $value =~ s/í/i/g and $value .= '2';
    $value =~ s/é/e/g and $value .= '2';
    $value =~ s/ú/u/g and $value .= '2';
    $value =~ s/ó/o/g and $value .= '2';
    $value =~ s/á/a/g and $value .= '2';

    $value =~ s/ě/e/g and $value .= '3';
    $value =~ s/ǎ/a/g and $value .= '3';
    $value =~ s/ǒ/o/g and $value .= '3';
    $value =~ s/ǔ/u/g and $value .= '3';
    $value =~ s/ǚ/u/g and $value .= '3';
    $value =~ s/ǐ/i/g and $value .= '3';

    $value =~ s/ò/o/g and $value .= '4';
    $value =~ s/à/a/g and $value .= '4';
    $value =~ s/è/e/g and $value .= '4';
    $value =~ s/ù/u/g and $value .= '4';
    $value =~ s/ì/i/g and $value .= '4';

    $value =~ s/\d//g unless $self->{tone};
    return $value;
}

1;
__END__

=encoding utf8

=head1 NAME

Lingua::Han::PinYin - Retrieve the Mandarin(PinYin) of Chinese character(HanZi).

=head1 SYNOPSIS

  use Lingua::Han::PinYin;

  my $h2p = Lingua::Han::PinYin->new();

  # han2pinyin
  my $pinyin = $h2p->han2pinyin("我爱你"); # woaini
  my @result = $h2p->han2pinyin("爱你"); # @result = ('ai', 'ni');

=head1 DESCRIPTION

Convert Mandarin to its spell

=head2 RETURN VALUE

Usually, it returns its pinyin/spell.

if not (I mean it's not a Chinese character), returns the original word.

=head2 OPTION

=over 4

=item tone => 1|0

default is 0. if 1, return B<kua4> instead of B<kua>

    my $h2p = Lingua::Han::PinYin->new(tone => 1);
    print $h2p->han2pinyin("我"); #wo3
    my @result = $h2p->han2pinyin("爱你"); # @result = ('ai4', 'ni3');

=item unicode => 1|0

default is 0, if 1, return B<kuà> instead of B<kua4> OR B<kua>

    my $h2p = Lingua::Han::PinYin->new(unicode => 1);
    print $h2p->han2pinyin("叶问"); # yèwèn

=back

=head2 METHODS

=over 4

=item han2pinyin

    print $h2p->han2pinyin("林道"); #lin2dao4
    print $h2p->han2pinyin("I love 余瑞华 a"); #i love yuruihua a

=item han2pinyin1

for 1 chinese letter at a time, han2pinyin1 is faster

    # if you are sure to pass 1 Chinese letter at a time, han2pinyin1 is faster
    print $h2p->han2pinyin1("我"); # wo

=item gb2pinyin

if you are sure your encoding is GB2312, gb2pinyin is faster

    print $h2p->gb2pinyin("I love （汉语）拼―音 Ah"); # I love （hanyu）pin―yin Ah

=back

=head1 SEE ALSO

L<Unicode::Unihan>

=head1 AUTHORS

Fayland Lam, C<< <fayland at gmail.com> >>

Tong Sun, C<< <suntong at cpan.org> >>

=head1 COPYRIGHT

Copyright (c) 2005-2012 *AUTHORS* All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>
