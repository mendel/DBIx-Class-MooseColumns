#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most;

use FindBin;
use Path::Class;
use lib dir($FindBin::Bin)->subdir('lib')->stringify;

use TestSchema;

my $schema = TestSchema->connect("dbi:SQLite:t/var/TestSchema.db");

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

done_testing;
