#!/usr/local/bin/perl -w

use lib '.';
require Maker::Package;
require Maker::Rules;

{
    my $pk = new Maker::Package(top=>'Maker');
    $pk->pm_2version('Maker/Package.pm');
    $pk->default_targets('Maker');

    my $inst = {
	man3 => [ 'Maker.3' ],
	lib => [ 'Maker.pod', 'Maker/', 'Maker/Package.pm', 'Maker/Rules.pm' ],
    };

    my $r = Maker::Rules->new($pk, 'perl-module');
    $pk->a(new Maker::Seq($r->blib($inst),
			  $r->pod2man('Maker.pod', 3),
			  $r->populate_blib($inst),
			  new Maker::Unit('Maker', sub {}),
			  ),
	   $r->install($inst),
	   $r->uninstall($inst),
	   new Maker::Unit('_test', sub {}),
	   );

    $pk->load_argv_flags;
    $pk->top_go(@ARGV);
}

