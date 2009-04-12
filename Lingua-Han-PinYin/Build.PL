use strict;
use Module::Build;

my $build = Module::Build->new(
    create_makefile_pl  => 'traditional',
    license            => 'perl',
    module_name        => 'Lingua::Han::PinYin',
    requires           => {
        'Lingua::Han::Utils' => '0.10',
        'File::Spec' => 0,
    },
);
$build->add_build_element('dat');
$build->create_build_script;
