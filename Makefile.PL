#!/usr/bin/env perl

use strict;
use warnings;

use inc::Module::Install 0.91;

use Module::Install::AuthorRequires 0.02;
use Module::Install::ReadmeFromPod 0.06;
use Module::Install::Repository 0.06;
use Module::Install::ExtraTests 0.006;

name        'MooseX-DBIC-AddColumn';
all_from    'lib/MooseX/DBIC/AddColumn.pm';
readme_from 'lib/MooseX/DBIC/AddColumn.pm' => 'clean';
auto_set_repository;

requires 'DBIx::Class::MooseColumns';

extra_tests;

auto_install;

WriteAll;
