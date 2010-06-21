{
	schema_class  => 'TestSchema',
  fixture_sets  => {
    basic => {
      'Artist'  => [
        [ 'artist_id',  'name', 'title',  'address',      'birthday',   ],
        [ 1,            'foo',  'Dr',     'Some where 1', '2010-06-21', ],
      ],
    },
  },
}
