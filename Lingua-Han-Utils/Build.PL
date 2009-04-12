use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Lingua::Han::Utils',
    license             => 'perl',
    dist_author         => 'Fayland Lam <fayland@gmail.com>',
    dist_version_from   => 'lib/Lingua/Han/Utils.pm',
    create_makefile_pl  => 'traditional',
    build_requires => {
        'Test::More' => 0,
        'Encode::Guess' => 0,
    },
);

$builder->create_build_script();

1;