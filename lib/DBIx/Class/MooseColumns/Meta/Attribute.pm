package DBIx::Class::MooseColumns::Meta::Attribute;

use Moose::Role;
use namespace::autoclean;

use Moose::Util qw(ensure_all_roles);

=head1 NAME

DBIx::Class::MooseColumns::Meta::Attribute - Attribute metaclass trait for DBIx::Class::MooseColumns

=cut

around new => sub {
  my ($orig, $class, $name, %options) = @_;

  my $column_info = delete $options{add_column};
  $column_info->{accessor} = $options{accessor} if $options{accessor};

  my $is_inflated_column;

  if ($column_info) {
    my $target_pkg = $options{definition_context}->{package};
    
    $target_pkg->add_column($name => $column_info);

    # removing the accessor method that CAG installed (otherwise Moose
    # complains)
    $target_pkg->meta->remove_method($column_info->{accessor} || $name);

    #FIXME respect the API - check for $target_pkg->inflate_column() calls instead of peeking into the guts of the object
    if (exists $target_pkg->column_info($name)->{_inflate_info}) {
      $is_inflated_column = 1;
    }
  }

  my $self = $class->$orig($name, %options);

  if ($column_info) {
    ensure_all_roles($self,
      $is_inflated_column
        ? 'DBIx::Class::MooseColumns::Meta::Attribute::DBICColumn::Inflated'
        : 'DBIx::Class::MooseColumns::Meta::Attribute::DBICColumn'
    );
  }

  return $self;
};

1;
