/**
Q1
Find the 5 oldest users of the Instagram from the database provided**/

 SELECT username, created_at 
 FROM ig_clone.users
 order by created_at 
 limit 5

/**
Q2
Find the users who have never posted a single photo on Instagram**/


 SELECT u.username
 FROM ig_clone.users u
 left join
 ig_clone.photos p
 on u.id = p.user_id
 where
 p.user_id is NULL
 order by u.username

/**
Q3
Identify the winner of the contest and provide their details to the team**/
with base as
(
  SELECT likes.photo_id, users.username, count(likes.user_id) as like_users
  From ig_clone.likes likes
  inner join ig_clone.photos photos
  ON likes.photo_id = photos.id
  inner join ig_clone.users users
  ON photos.user_id = users.id
  group by likes.photo_id, users.username
  order by like_users desc
  limit 1
)
Select username from base

# Q4
# Hashtag Researching: A partner brand wants to know, which hashtags to use in the post to reach the most people on the platform.
# Your Task: Identify and suggest the top 5 most commonly used hashtags on the platform
with base as
(  SELECT count(photo_tags.photo_id) as total_num,
   tags.tag_name
 From ig_clone.tags tags
 inner join ig_clone.photo_tags photo_tags
 on tags.id = photo_tags.tag_id
 group by tag_name
 order by total_num desc
 limit 5
)
  SELECT tag_name from base

# Q5 - Launch AD Campaign: The team wants to know, which day would be the best day to launch ADs.
# Your Task: What day of the week do most users register on? Provide insights on when to schedule an ad campaign

SELECT WEEKDAY(created_at) as weekday,
count(username) as num_user
from 
ig_clone.users
group by 1
order by 2 desc

Q6 # User Engagement: Are users still as active and post on Instagram or they are making fewer posts
# Your Task: Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of users

with cte as(
  select u.id as userid,
  count(p.id) as photoid
  from 
  ig_clone.users u
  left join
  ig_clone.photos p
  on u.id=p.user_id
  group by u.id
  )
  select sum(photoid)/count(userid) as photos_per_user

  from cte
  where photoid>0
