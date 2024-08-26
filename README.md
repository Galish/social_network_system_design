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
	- user is subscribed to 200 other users at any given time
	- user publishes 5 posts per month
	- user views 30 post per day
	- user reacts to 15 posts per day (50% of viewed posts)
	- user posts 6 comments per day (20% of viewed posts)
- Audience from Russian-speaking countries
- There is seasonality is present
- Operation time limits:
	- feed rendering should take less than 1 second
	- post and comment publishing should take less than 1 second
	- location search should take less than 3 seconds
- Maximum number of users to follow is 10000
- Availability 99,99%


### Basic calculations

Posts:

	RPS (write) = 10 000 000 / 6 / 86 400 ~= 20
	RPS (read) = 10 000 000 * 30 / 86 400 ~= 3 500

	Traffic (write) = 25 MB (text + pictures) * 20 = 500 MB/s
	Traffic (read) = 5 MB (text + preview) * 3 500 = 17.5 GB/s

	Storage: 160 SSD (SATA) disks

	Data generated (in 1 year) = 500 MB/s * 86 400 * 365 ~= 16 PB

	SSD (nVME) = 533 disks
	- by capacity = 16 PB / 30 TB = 533
	- by throughput = 17.5 / 3 GB/s = 6
	- by IOPS = 3 500 / 10000 = 1

	SSD (SATA) = 160 disks
	- by capacity = 16 PB / 100 TB = 160
	- by throughput = 17500 / 500 MB/s = 35
	- by IOPS = 3 500 / 1000 = 4

	HDD = 500 disks
	- by capacity = 16 PB / 32 TB = 500
	- by throughput = 17500 / 100 MB/s = 175
	- by IOPS = 3 500 / 100 = 35


	Hosts: 80 shards (2 disks) * 3 replicas = 240

	Configuration:
	- sharding by `user_id` (key based)
	- replication master-slave, async, RF=3

Likes:

	RPS (write) = 10 000 000 * 15 / 86 400 ~= 1 800
	RPS (read) = 10 000 000 * 30 * 50 (likes per post) / 86 400 ~= 180 000

	Traffic (write) = 100 B * 1 800 = 180 KB/s
	Traffic (read) = 100 B * 180 000 = 18 MB/s

	Storage: 18 SSD (nVME) disks

	Data generated (in 1 year) = 180 KB/s * 86 400 * 365 ~= 6 TB

	SSD (nVME) = 18 disks
	- by capacity = 6 TB = 1
	- by throughput = 18 MB/s = 1
	- by IOPS = 180 000 / 10 000 = 18

	SSD (SATA) = 180 disks
	- by capacity = 6 TB = 1
	- by throughput = 18 MB/s = 1
	- by IOPS = 180 000 / 1 000 = 180

	HDD = 1800 disks
	- by capacity = 6 TB = 1
	- by throughput = 18 MB/s = 1
	- by IOPS = 180 000 / 100 = 1800


	Hosts: 9 shards (2 disks) * 3 replicas = 27

	Configuration:
	- sharding by `post_id` (key based)
	- replication master-slave, async, RF=3

Comments:

	RPS (write) = 10 000 000 * 6 / 86 400 ~= 700
	RPS (read) = 10 000 000 * 30 * 10 (comments per post) / 86 400 ~= 35 000

	Traffic (write) = 500 B * 700 = 350 KB/s
	Traffic (read) = 500 B * 35 000 = 17.5 MB/s


	Storage: 4 SSD (nVME) disks

	Data generated (in 1 year) = 350 KB/s * 86 400 * 365 ~= 12 TB

	SSD (nVME) = 4 disks
	- by capacity = 12 TB = 1
	- by throughput = 17.5 MB/s = 1
	- by IOPS = 35 000/ 10 000 = 4

	SSD (SATA) = 35 disks
	- by capacity = 12 TB = 1
	- by throughput = 17.5 MB/s = 1
	- by IOPS = 35 000/ 1 000 = 35

	HDD = 350 disks
	- by capacity = 12 TB = 1
	- by throughput = 17.5 MB/s = 1
	- by IOPS = 35 000 / 100 = 350


	Hosts: 2 shards (2 disks) * 3 replicas = 6

	Configuration:
	- sharding by `post_id` (key based)
	- replication master-slave, async, RF=3

