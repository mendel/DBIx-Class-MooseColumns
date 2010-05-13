#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most;

use FindBin;
use Path::Class;

eval "use Test::Perl::Critic";
plan skip_all => "Test::Perl::Critic required to run 04-critic.t" if $@;

my $rcfile = dir($FindBin::Bin)->file('04-critic.rc')->stringify;
Test::Perl::Critic->import( -profile => $rcfile );
all_critic_ok();
