#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most;

use FindBin;
use Path::Class;
use lib dir($FindBin::Bin)->subdir('lib')->stringify;

use Test::DBIx::Class;

fixtures_ok 'basic', 'installed the basic fixtures from configuration files';

{
  warnings_are {
    eval <<'END' or die;
      package TestSchema::Result::Artist;

      use Moose;
      use namespace::autoclean;

      my %immutable_options = __PACKAGE__->meta->immutable_options;
      __PACKAGE__->meta->make_mutable;

      has votes => (
        isa => 'Int',
        is  => 'rw',
        add_column => {
        },
      );

      __PACKAGE__->meta->make_immutable(%immutable_options);
END
  } [], "No warnings while loading the test schema";
}

done_testing;
