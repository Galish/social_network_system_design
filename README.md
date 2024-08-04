# Social network for travelers - System Design

System design of a social network for travelers for the [system design course](https://balun.courses/courses/system_design).

### Functional requirements:
- Publish posts containing photos, description and location
- Like and comment on user posts
- Follow other user accounts
- Search for popular locations and view posts from those places
- View home feed
- View other user feeds


### Non-functional requirements:

- 10 000 000 DAU
- Behavior:
	- user follows 200 other users
	- user publishes 5 posts per month
	- user views 30 post per day
	- user reacts to 15 posts per day (50% of viewed posts)
	- user posts 6 comments per day (20% of viewed posts)
- Audience from Russian-speaking countries
- No seasonality
- No service operation time limit
- Maximum number of users to follow is 1000
- Availability 99,99%


### Basic calculations

Posts:

	RPS (write) = 10 000 000 / 6 / 86 400 ~= 20
	RPS (read) = 10 000 000 * 30 / 86 400 ~= 3 500

	Traffic (write) = 25 MB (text + pictures) * 20 = 500 MB/s
	Traffic (read) = 5 MB (text + preview) * 3 500 = 17.5 GB/s

Reactions:

	RPS (write) = 10 000 000 * 15 / 86 400 ~= 1 800
	RPS (read) = 10 000 000 * 30 * 50 (likes per post) / 86 400 ~= 180 000

	Traffic (write) = 100 B * 1 800 = 180 KB/s
	Traffic (read) = 100 B * 180 000 = 18 MB/s

Comments:

	RPS (write) = 10 000 000 * 6 / 86 400 ~= 700
	RPS (read) = 10 000 000 * 30 * 10 (comments per post) / 86 400 ~= 35 000

	Traffic (write) = 500 B * 700 = 350 KB/s
	Traffic (read) = 500 B * 35 000 = 17.5 MB/s



