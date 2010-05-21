package TestSchema::Result::Artist;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;

use MooseX::DBIC::AddColumn;

extends 'DBIx::Class::Core';

__PACKAGE__->table('artist');

has artist_id => (
  isa => 'Int',
  is  => 'rw',
  add_column => {
    is_auto_increment => 1,
  },
);

has name => (
  isa => 'Str',
  is  => 'rw',
  add_column => {
    is_nullable => 0,
  },
);

has guess => (
  isa => 'Int',
  is  => 'ro',
  default => sub { int(rand 100)+1 },
);

__PACKAGE__->set_primary_key('artist_id');

__PACKAGE__->meta->make_immutable;

1;
