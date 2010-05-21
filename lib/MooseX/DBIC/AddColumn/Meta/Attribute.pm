package MooseX::DBIC::AddColumn::Meta::Attribute;

use Moose::Role;

=head1 NAME

MooseX::DBIC::AddColumn::Meta::Attribute - Attribute metaclass trait for MooseX::DBIC::AddColumn

=cut

use MooseX::DBIC::AddColumn::Meta::Method::Accessor;

has _moosex_dbic_addcolumn_column_info => (
  isa       => 'Maybe[HashRef]',
  is        => 'rw',
  predicate => 'has__moosex_dbic_addcolumn_column_info',
);

around accessor_metaclass => sub {
  return 'MooseX::DBIC::AddColumn::Meta::Method::Accessor';
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
    $self->_moosex_dbic_addcolumn_column_info($column_info);
  }

  return $self;
};

1;
