Table posts {
  id integer [primary key]
  text text [note: 'Content of the post']
  created_by integer
  created_at timestamp
  likes_count integer [default: 0]
  comments_count integer [default: 0]
  location_id integer
  media integer[]
}

Table comments {
  id integer [primary key]
  text text [note: 'Content of the comment']
  parent_id integer
  post_id integer
  created_by integer
  created_at timestamp
}

Table likes {
  id integer [primary key]
  post_id integer
  created_by integer
  created_at timestamp
}

Ref: comments.post_id > posts.id

Ref: likes.post_id > posts.id
