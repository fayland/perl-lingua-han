use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Lingua::Han::Stroke',
    license             => 'perl',
    dist_author         => 'Fayland Lam <fayland@gmail.com>',
    dist_version_from   => 'lib/Lingua/Han/Stroke.pm',
    create_makefile_pl  => 'traditional',
    build_requires => {
    	'Lingua::Han::Utils' => 0,
        'Test::More' => 0,
    },
);
$builder->add_build_element('dat');
$builder->create_build_script();

1;