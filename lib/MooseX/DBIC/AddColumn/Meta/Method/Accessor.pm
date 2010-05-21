package MooseX::DBIC::AddColumn::Meta::Method::Accessor;

use Moose;
use namespace::autoclean;

=head1 NAME

MooseX::DBIC::AddColumn::Meta::Method::Accessor - Accessor metaclass for MooseX::DBIC::AddColumn

=cut

extends 'Moose::Meta::Method::Accessor';

#FIXME Moose::Meta::Method::Accessor does not use this currently, write _generate_inline_predicate instead
around _inline_has => sub {
  my ($orig, $self, $instance) = (shift, shift, @_);

  my $attr = $self->associated_attribute;
  if ($attr->has__moosex_dbic_addcolumn_column_info) {
    my ($slot_name) = $attr->slots;

    return sprintf q[%s->has_column_loaded("%s")], $instance, quotemeta($slot_name);
  }
  else {
    return $self->$orig(@_);
  }
};

around _inline_get => sub {
  my ($orig, $self, $instance) = (shift, shift, @_);

  my $attr = $self->associated_attribute;
  if ($attr->has__moosex_dbic_addcolumn_column_info) {
    my ($slot_name) = $attr->slots;

    return sprintf q[%s->get_column("%s")], $instance, quotemeta($slot_name);
  }
  else {
    return $self->$orig(@_);
  }
};

around _inline_store => sub {
  my ($orig, $self, $instance, $value) = (shift, shift, @_);

  my $attr = $self->associated_attribute;
  if ($attr->has__moosex_dbic_addcolumn_column_info) {
    my ($slot_name) = $attr->slots;

    return sprintf q[%s->set_column("%s", "%s")], $instance, quotemeta($slot_name), $value;
  }
  else {
    return $self->$orig(@_);
  }
};

around _inline_access => sub {
  my ($orig, $self, $instance) = (shift, shift, @_);

  $self->throw_error(__PACKAGE__ . " cannot implement _inline_access()");
};

around _inline_get_old_value_for_trigger => sub {
  my ($orig, $self, $instance) = (shift, shift, @_);

  my $attr = $self->associated_attribute;
  if ($attr->has__moosex_dbic_addcolumn_column_info) {
    return '' unless $attr->has_trigger;

    return
        'my @old = '
      . $self->_inline_has($instance) . q{ ? }
      . $self->_inline_get($instance) . q{ : ()} . ";\n";
  }
  else {
    return $self->$orig(@_);
  }
};

#FIXME other methods (predicate, clearer, initializer, ...?)
#FIXME non-inline methods? (Moose always inlines all of them currently)

1;
