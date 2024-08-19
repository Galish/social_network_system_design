Table follows {
  following_user_id integer
  followed_user_id integer
  created_at timestamp
}

Table users {
  id integer [primary key]
  username varchar
  name varchar
  description varchar
  location varchar
  created_at timestamp
  following_count int
  followers_count int
}

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

Table locations {
  id integer [primary key]
  title varchar
  description text [note: 'Location description']
  created_by integer
  created_at timestamp
  coordinates point
}

Table media {
  id integer [primary key]
  format string
  size int
  uploaded_by string
  uploaded_at timestamp
}

Ref: posts.created_by > users.id

Ref: comments.created_by > users.id

Ref: comments.post_id > posts.id

Ref: likes.created_by > users.id

Ref: likes.post_id > posts.id

Ref: locations.id < posts.location_id

Ref: users.id < follows.following_user_id

Ref: users.id < follows.followed_user_id
