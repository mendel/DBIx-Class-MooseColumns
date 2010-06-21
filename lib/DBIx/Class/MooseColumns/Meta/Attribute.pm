package DBIx::Class::MooseColumns::Meta::Attribute;

use Moose::Role;

=head1 NAME

DBIx::Class::MooseColumns::Meta::Attribute - Attribute metaclass trait for DBIx::Class::MooseColumns

=cut

use DBIx::Class::MooseColumns::Meta::Method::Accessor;

has has_dbix_class_moosecolumns_column_info => (
  isa       => 'Bool',
  is        => 'rw',
);

has is_dbix_class_moosecolumns_inflated_column => (
  isa       => 'Bool',
  is        => 'rw',
);

around accessor_metaclass => sub {
  return 'DBIx::Class::MooseColumns::Meta::Method::Accessor';
};

around new => sub {
  my ($orig, $class, $name, %options) = @_;

  my $column_info = delete $options{add_column};
  $column_info->{accessor} = $options{accessor} if $options{accessor};

  my $is_inflated_column;

  if ($column_info) {
    my $target_pkg = $options{definition_context}->{package};
    
    $target_pkg->add_column($name => $column_info);

    # removing the accessor method that CAG installed (otherwise Moose complains)
    $target_pkg->meta->remove_method($column_info->{accessor} || $name);

    if (exists $target_pkg->column_info($name)->{_inflate_info}) {
      $is_inflated_column = 1;
    }
  }

  my $self = $class->$orig($name, %options);

  if ($column_info) {
    $self->has_dbix_class_moosecolumns_column_info(1);
  }

  #TODO respect the API - check for $target_pkg->inflate_column() calls instead of peeking into the guts of the object
  $self->is_dbix_class_moosecolumns_inflated_column($is_inflated_column);

  return $self;
};

1;
