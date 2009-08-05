package Lingua::Han::PinYin;

use strict;
use warnings;
our $VERSION = '0.12.2';

use File::Spec ();
use Lingua::Han::Utils qw/Unihan_value/;

sub new {
    my $class = shift;
    my $dir   = __FILE__;
    $dir =~ s/\.pm//o;
    -d $dir or die "Directory $dir nonexistent!";
    my $self = {@_};
    my %py;
    my $file = File::Spec->catfile( $dir, 'Mandarin.dat' );
    open( FH, $file ) or die "$file: $!";

    while (my $line = <FH>) {
        chomp($line);
        my ( $uni, $py );
        if ( $self->{duoyinzi} ) {
            ( $uni, $py ) = split(/\s+/, $line, 2);
        } else {
            ( $uni, $py ) = split(/\s+/, $line);
        }
        $py{$uni} = $py;
    }
    close(FH);
    $self->{'py'} = \%py;
    return bless $self => $class;
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
    
    unless ($self->{'tone'}) {
        $value =~ s/\d//isg;
        if ( $self->{duoyinzi} ) { # remove duplication
            my @duoyinzi = split(/\s+/, $value);
            my %saw;
            my @out = grep(!$saw{$_}++, @duoyinzi);
            $value = join(' ', @out);
        }
    }
    
    return lc($value);
}

1;
__END__

=encoding euc-cn

=head1 NAME

Lingua::Han::PinYin - Retrieve the Mandarin(PinYin) of Chinese character(HanZi).

=head1 SYNOPSIS

  use Lingua::Han::PinYin;
  
  my $h2p = new Lingua::Han::PinYin();
  
  # han2pinyin
  print $h2p->han2pinyin("我"); # wo
  my @result = $h2p->han2pinyin("爱你"); # @result = ('ai', 'ni');
  
  # if you are sure to pass 1 Chinese letter at a time, han2pinyin1 is faster
  print $h2p->han2pinyin1("我"); # wo
  # if you are sure your encoding is GB2312, gb2pinyin is faster
  print $h2p->gb2pinyin("I love （汉语）拼—音 Ah"); # I love （hanyu）pin—yin Ah

  # we can set the tone up
  my $h2p = new Lingua::Han::PinYin(tone => 1);
  print $h2p->han2pinyin("我"); #wo3
  my @result = $h2p->han2pinyin("爱你"); # @result = ('ai4', 'ni3');
  print $h2p->han2pinyin("林道"); #lin2dao4
  print $h2p->han2pinyin("I love 余瑞华 a"); #i love yuruihua a
  
  # for polyphone(duoyinzi)
  my $h2p = new Lingua::Han::PinYin(duoyinzi => 1, tone => 1);
  print $h2p->han2pinyin("行"); # 'xing2 hang2 xing4 hang4 heng2'

=head1 DESCRIPTION

There is a Chinese document @ L<http://www.fayland.org/project/Han-PinYin/>. It tells why and how I write this module.

=head1 RETURN VALUE

Usually, it returns its pinyin/spell. It includes more than 20,000 words (from Unicode.org Unihan.txt, version 4.1.0).

if not(I mean it's not a Chinese character), returns the original word;

=head1 OPTION

=over 4

=item tone => 1|0

default is 0. if tone is needed, plz set this to 1.

=item duoyinzi => 1|0

default is 0.

=back 

=head1 CAVEAT

The ascii 'v' is used instead of the unicode 'yu' Since version 0.06.

=head1 SEE ALSO

L<Unicode::Unihan>

=head1 AUTHORS

Fayland Lam, C<< <fayland at gmail.com> >>

Tong Sun, C<< <suntong at cpan.org> >>

=head1 COPYRIGHT

Copyright (c) 2005-2009 *AUTHORS* All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>
