package TestSchema::Result::Artist;

use Moose;
#TODO why does MooseX::NonMoose makes Test::DBIx::Class break?
#use MooseX::NonMoose;
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

has title => (
  isa => 'Str',
  is  => 'rw',
  accessor => '_title',
  add_column => {
  },
);

has guess => (
  isa => 'Int',
  is  => 'ro',
  default => sub { int(rand 100)+1 },
);

# silly example (better to do this with a trigger) but i couldn't invent
# anything better :-)
sub title
{
  my ($self, $value) = (shift, @_);

  if (@_ > 0) {
    die "Invalid title" if defined $value && $value ne 'Dr' && $value ne 'Prof';
    return $self->_title($value);
  }
  else {
    return $self->_title;
  }
}

__PACKAGE__->set_primary_key('artist_id');

#TODO why does MooseX::NonMoose makes Test::DBIx::Class break?
#__PACKAGE__->meta->make_immutable;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);

1;
