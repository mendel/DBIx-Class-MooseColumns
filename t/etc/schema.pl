{
	schema_class  => 'TestSchema',
  fixture_sets  => {
    basic => {
      'Artist'  => [
        [ 'artist_id',  'name', 'title',  ],
        [ 1,            'foo',  'Dr',     ],
      ],
    },
  },
}
