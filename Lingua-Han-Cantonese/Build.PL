use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Lingua::Han::Cantonese',
    license             => 'perl',
    dist_author         => 'Fayland Lam <fayland@gmail.com>',
    dist_version_from   => 'lib/Lingua/Han/Cantonese.pm',
    create_makefile_pl  => 'traditional',
    build_requires => {
        'Test::More' => 0,
        'File::Spec' => 0,
        'Lingua::Han::Utils' => '0.10',
    },
);
$builder->add_build_element('dat');

$builder->create_build_script();

1;