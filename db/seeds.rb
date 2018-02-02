# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#cohorts
co1030 = Cohort.create(name:"10302017", start_date:DateTime.new(2017,10,30))
co1120 = Cohort.create(name:"11202017", start_date:DateTime.new(2017,11,20))

#tags
javascript = Tag.create(slug: "javascript", name: "JavaScript")
react = Tag.create(slug: "react", name: "React")
rails = Tag.create(slug: "ruby-on-rails", name: "Ruby on Rails")

#users
paul = User.create(name:"Paul Kristapovich", medium_username:"pawlkris", github:"pawlkris", email:"paulkristapovich@gmail.com", password:"pawlkris", cohort_id:1, image_slug: "0*jTmGCZqh0YvpkEdn.")
seth = User.create(name:"Seth Barden", medium_username:"sethbarden", password:"sethbarden", cohort_id:1, image_slug: "0*hM4avF8OvdhZkmWP.")



#post
heroku = Post.create(title:"Rails to Heroku: A brief walkthrough for you", slug:"rails-to-heroku-a-brief-walkthrough-for-you-9324c007fd0f", date:DateTime.parse(Time.at(1513884680).strftime('%Y/%m/%d')), claps:8, reading_time:4, author_id:1)
event_delegation = Post.create(title:"Rails to Heroku: A brief walkthrough for you", slug:"event-delegation-in-javascript-61347d115b33", date: DateTime.parse(Time.at(1513884680).strftime('%Y/%m/%d')), claps:2, reading_time:4, author_id:2)


#post_tag... yes this doesn't make sense
herokuRails = PostTag.create(tag_id:3, post_id:1)

#fan_post
paul_event_delegation = FanPost.create(fan_id:1, liked_post_id:2)

#seth.authored_posts[0].fans returns the user fan
#paul.liked_posts returns article user likes
