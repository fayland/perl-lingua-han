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
        'Encode::Detect::CJK' => 0,
    },
    meta_merge     => {
        resources => {
            repository => 'http://github.com/fayland/perl-lingua-han/tree/master',
        }
    },
);

$builder->create_build_script();

1;