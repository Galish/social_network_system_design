Table users {
  id integer [primary key]
  username varchar
  name varchar
  description varchar
  location_id integer
  created_at timestamp
  following_count int
  followers_count int
}

Table follows {
  following_user_id integer
  followed_user_id integer
  created_at timestamp
}

Ref: users.id < follows.following_user_id

Ref: users.id < follows.followed_user_id
