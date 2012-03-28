#!/usr/bin/perl

use strict;
use warnings;

# get data from http://www.unicode.org/Public/UNIDATA/Unihan.zip
# and unzip it

open(my $MANDARIN, '>', 'Mandarin.dat') or die $!;
open(my $CANTONESE, '>', 'Cantonese.dat') or die $!;
open(my $STROKE, '>', 'Stroke.dat') or die $!;
my ($m, $c, $s);
open(my $fh, '<', 'Unihan_Readings.txt') or die $!;
while (<$fh>) {
    next if (/\^#/);
    if (/^U\+(\w+)\s+(kCantonese|kMandarin)\s+(.+)$/) {
        if ($2 eq 'kCantonese') {
            print $CANTONESE "$1\t$3\n";
            $c++;
        } elsif($2 eq 'kMandarin') {
            my $code = $1;
            my $mandarin = $3;
            $mandarin =~ s/Ü/V/isg;
            print $MANDARIN "$code\t$mandarin\n";
            $m++;
        }
    }
}
close($fh);
open($fh, '<', 'Unihan_DictionaryLikeData.txt') or die $!;
while (<$fh>) {
    next if (/\^#/);
    if (/^U\+(\w+)\s+kTotalStrokes\s+(.+)$/) {
        print $STROKE "$1\t$2\n";
        $s++;
    }
}
close($fh);
close($MANDARIN);
close($CANTONESE);
close($STROKE);

print "mandarin has $m, cantonese has $c, stroke has $s\n";