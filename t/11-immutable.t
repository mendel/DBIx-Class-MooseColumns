#!/usr/bin/env perl

use strict;
use warnings;

use Test::Steering;

use FindBin;
use Path::Class;
use lib dir($FindBin::Bin)->subdir('lib')->stringify;

include_tests { test_args => [ 'immutable' ] }, 'agg-t/user/*.t';
