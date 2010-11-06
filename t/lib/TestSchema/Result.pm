package TestSchema::Result;

use Moose;
#TODO why does MooseX::NonMoose makes Test::DBIx::Class break?
#use MooseX::NonMoose;
use namespace::autoclean;

use TestUtils::MakeInstanceMetaClassNonInlinableIf
  $ENV{DBIC_MOOSECOLUMNS_NON_INLINABLE};

use DBIx::Class::MooseColumns;

extends 'DBIx::Class::Core';

#TODO why does MooseX::NonMoose makes Test::DBIx::Class break?
#__PACKAGE__->meta->make_immutable
#  if $ENV{DBIC_MOOSECOLUMNS_IMMUTABLE} && !$ENV{DBIC_MOOSECOLUMNS_NON_INLINABLE};
__PACKAGE__->meta->make_immutable(inline_constructor => 0)
  if $ENV{DBIC_MOOSECOLUMNS_IMMUTABLE} && !$ENV{DBIC_MOOSECOLUMNS_NON_INLINABLE};

1;
