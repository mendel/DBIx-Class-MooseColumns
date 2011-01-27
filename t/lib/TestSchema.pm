package TestSchema;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;

extends 'DBIx::Class::Schema';

# just to make MooseX::NonMoose happy
sub new { }

__PACKAGE__->load_namespaces;

__PACKAGE__->meta->make_immutable;

1;
