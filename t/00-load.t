#!/usr/bin/env perl -T

use strict;
use warnings;

use Test::Most;

BEGIN {
  use_ok( 'DBIx::Class::MooseColumns' );
}

diag( "Testing DBIx::Class::MooseColumns $DBIx::Class::MooseColumns::VERSION, Perl $], $^X" );

done_testing;
