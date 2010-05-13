#!/usr/bin/env perl -T

use strict;
use warnings;

use Test::Most tests => 1;

BEGIN {
	use_ok( 'MooseX::DBIC::AddColumn' );
}

diag( "Testing MooseX::DBIC::AddColumn $MooseX::DBIC::AddColumn::VERSION, Perl $], $^X" );
