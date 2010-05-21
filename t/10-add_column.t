#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most;

use FindBin;
use Path::Class;
use lib dir($FindBin::Bin)->subdir('lib')->stringify;

use TestSchema;

my $schema = TestSchema->connect("dbi:SQLite:dbname=t/var/TestSchema.db");

{
  throws_ok {
    $schema->resultset('Artist')->result_source->column_info('guess');
  } qr/No such column ['"`]?guess['"`]?/,
    "the 'guess' attribute has no column_info";

  lives_and {
    cmp_deeply(
      $schema->resultset('Artist')->result_source->column_info('artist_id'),
      superhashof({
        is_auto_increment => 1,
      })
    );
  } "column_info of 'id' contains ('is_auto_increment' => 1)";

  lives_and {
    cmp_deeply(
      $schema->resultset('Artist')->result_source->column_info('name'),
      superhashof({
        is_nullable => 0,
      })
    );
  } "column_info of 'name' contains ('is_nullable' => 0)";
}

{
  my $artist1 = $schema->resultset('Artist')->find({ artist_id => 1 });

  lives_and {
    cmp_deeply(
      $artist1->name,
      'foo'
    );
  } "value returned by 'name' accessor is 'foo'";

  lives_and {
    cmp_deeply(
      $artist1->name('bar'),
      'bar'
    );
  } "calling the 'name' accessor to set 'name' to 'bar' returns 'bar'";

  lives_and {
    cmp_deeply(
      $artist1->get_column('name'),
      'bar'
    );
  } "value returned by get_column('name') is 'bar'";

  lives_and {
    cmp_deeply(
      $artist1->name('bar'),
      'bar'
    );
  } "value returned by 'name' accessor is 'bar'";

  lives_ok {
    $artist1->set_column(name => 'quux');
  } "calling set_column('name', 'quux') does not die";

  lives_and {
    cmp_deeply(
      $artist1->name,
      'quux'
    );
  } "value returned by 'name' accessor is 'quux'";

  #FIXME other methods (predicate, clearer, ...)
  #FIXME test Moose triggers
}

done_testing;
