#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most;

use FindBin;
use Path::Class;
use lib dir($FindBin::Bin)->subdir('lib')->stringify;

use Test::DBIx::Class;

fixtures_ok 'basic', 'installed the basic fixtures from configuration files';

{
  throws_ok {
    Schema->resultset('Artist')->result_source->column_info('guess');
  } qr/No such column ['"`]?guess['"`]?/,
    "the 'guess' attribute has no column_info";

  lives_and {
    cmp_deeply(
      Schema->resultset('Artist')->result_source->column_info('artist_id'),
      superhashof({
        is_auto_increment => 1,
      })
    );
  } "column_info of 'id' contains ('is_auto_increment' => 1)";

  lives_and {
    cmp_deeply(
      Schema->resultset('Artist')->result_source->column_info('name'),
      superhashof({
        is_nullable => 0,
      })
    );
  } "column_info of 'name' contains ('is_nullable' => 0)";
}

{
  my $artist1 = Schema->resultset('Artist')->find({ artist_id => 1 });

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

{
  my $artist1 = Schema->resultset('Artist')->find({ artist_id => 1 });

  lives_and {
    cmp_deeply(
      $artist1->title,
      'Dr'
    );
  } "value returned by 'title' method is 'Dr'";

  lives_and {
    cmp_deeply(
      $artist1->title('Prof'),
      'Prof'
    );
  } "calling the 'title' method to set 'title' to 'Prof' returns 'Prof'";

  lives_and {
    cmp_deeply(
      $artist1->get_column('title'),
      'Prof'
    );
  } "value returned by get_column('title') is 'Prof'";

  lives_and {
    cmp_deeply(
      $artist1->title('Prof'),
      'Prof'
    );
  } "value returned by 'title' method is 'Prof'";

  throws_ok {
    $artist1->title('Mr')
  } qr/Invalid title/,
    "calling set_column('title', 'Mr') dies";

  lives_ok {
    $artist1->set_column(title => undef);
  } "calling set_column('title', undef) does not die";

  lives_and {
    cmp_deeply(
      $artist1->title,
      undef
    );
  } "value returned by 'title' method is undef";
}

done_testing;
