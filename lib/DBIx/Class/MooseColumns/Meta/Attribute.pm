package DBIx::Class::MooseColumns::Meta::Attribute;

use Moose::Role;

=head1 NAME

DBIx::Class::MooseColumns::Meta::Attribute - Attribute metaclass trait for DBIx::Class::MooseColumns

=cut

use DBIx::Class::MooseColumns::Meta::Method::Accessor;

has _dbix_class_moosecolumns_column_info => (
  isa       => 'Maybe[HashRef]',
  is        => 'rw',
  predicate => 'has__dbix_class_moosecolumns_column_info',
);

around accessor_metaclass => sub {
  return 'DBIx::Class::MooseColumns::Meta::Method::Accessor';
};

around new => sub {
  my ($orig, $class, $name, %options) = @_;

  my $column_info = delete $options{add_column};
  $column_info->{accessor} = $options{accessor} if $options{accessor};

  if ($column_info) {
    my $target_pkg = $options{definition_context}->{package};
    
    $target_pkg->add_column($name => $column_info);

    # removing the accessor method that CAG installed (otherwise Moose complains)
    $target_pkg->meta->remove_method($column_info->{accessor} || $name);
  }

  my $self = $class->$orig($name, %options);

  if ($column_info) {
    $self->_dbix_class_moosecolumns_column_info($column_info);
  }

  return $self;
};

1;
