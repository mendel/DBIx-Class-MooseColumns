#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most;

use FindBin;
use Path::Class;
use lib dir($FindBin::Bin)->parent->subdir('t', 'lib')->stringify;

use Test::DBIx::Class;

fixtures_ok 'basic', 'installed the basic fixtures from configuration files';

{
  warnings_are {
    eval <<'END' or die;
      package TestSchema::Result::Artist;

      use Moose;
      use namespace::autoclean;

      my $meta = __PACKAGE__->meta;
      my $immutable_options
        = $meta->is_immutable  ? { $meta->immutable_options }
                               : undef;
      $meta->make_mutable if $immutable_options;

      has votes => (
        isa => 'Int',
        is  => 'rw',
        add_column => {
        },
      );

      $meta->make_immutable(%$immutable_options)
        if $immutable_options;

      1;
END
  } [], "No warnings while loading the test schema";
}

done_testing;
