Table locations {
  id integer [primary key]
  title varchar
  description text [note: 'Location description']
  created_by integer
  created_at timestamp
  coordinates point
}
