{
	schema_class  => 'TestSchema',
  fixture_sets  => {
    basic => {
      'Artist'  => [
        [ 'artist_id',  'name', 'title',  'address',      ],
        [ 1,            'foo',  'Dr',     'Some where 1', ],
      ],
    },
  },
}
