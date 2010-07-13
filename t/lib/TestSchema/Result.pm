package TestSchema::Result;

use Moose;
#TODO why does MooseX::NonMoose makes Test::DBIx::Class break?
#use MooseX::NonMoose;
use namespace::autoclean;

use DBIx::Class::MooseColumns;

extends 'DBIx::Class::Core';

#TODO why does MooseX::NonMoose makes Test::DBIx::Class break?
#__PACKAGE__->meta->make_immutable if grep { $_ eq 'immutable' } @ARGV;
__PACKAGE__->meta->make_immutable(inline_constructor => 0)
  if grep { $_ eq 'immutable' } @ARGV;

1;
