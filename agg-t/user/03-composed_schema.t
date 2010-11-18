#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most;

use FindBin;
use Path::Class;
use lib dir($FindBin::Bin)->parent->parent->subdir('t', 'lib')->stringify;

use Test::DBIx::Class;

use Class::MOP;

fixtures_ok 'basic', 'installed the basic fixtures from configuration files';

{
  my $composed_schema = Schema->compose_namespace('ComposedTestSchema');

  my $artist_result_class = $composed_schema->resultset('Artist')->result_class;

  lives_and {
    ok( $artist_result_class->does('TestSchema::Role::Dummy') );
  } "\$row_class->does() works on result classes of a composed schema"
}

done_testing;
