package MooseX::DBIC::AddColumn::Meta::Attribute;

use Moose::Role;

=head1 NAME

MooseX::DBIC::AddColumn::Meta::Attribute - Metaclass attribute for MooseX::DBIC::AddColumn

=cut

has _moosex_dbic_addcolumn_column_info => (
  isa => 'Maybe[HashRef]',
  is  => 'rw',
);

around new => sub {
  my ($orig, $class, $name, %options) = @_;

  my $column_info = delete $options{add_column};

  my $self = $class->$orig($name, %options);

  $self->_moosex_dbic_addcolumn_column_info($column_info);

  return $self;
};

after install_accessors => sub {
  my ($self) = @_;

  my $column_info = $self->_moosex_dbic_addcolumn_column_info;
  if ($column_info) {
    #FIXME instead of letting CAG overwrite the Class::MOP/Moose accessor use a custom accessor metaclass that delegates to DBIC's get_column/set_column
    $self->associated_class->name->add_column($self->name => $column_info);
  }
};

1;
