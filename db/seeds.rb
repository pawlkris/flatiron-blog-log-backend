# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# #cohorts
# co1030 = Cohort.create(name:"10302017", start_date:DateTime.new(2017,10,30))
# co1120 = Cohort.create(name:"11202017", start_date:DateTime.new(2017,11,20))
#
# #tags
# javascript = Tag.create(slug: "javascript", name: "JavaScript")
# react = Tag.create(slug: "react", name: "React")
# rails = Tag.create(slug: "ruby-on-rails", name: "Ruby on Rails")
#
# #users
# paul = User.create(name:"Paul Kristapovich", medium_username:"pawlkris", github:"pawlkris", email:"paulkristapovich@gmail.com", password:"pawlkris", cohort_id:1, image_slug: "0*jTmGCZqh0YvpkEdn.")
# seth = User.create(name:"Seth Barden", medium_username:"sethbarden", password:"sethbarden", cohort_id:1, image_slug: "0*hM4avF8OvdhZkmWP.")
#
#
#
# #post
# heroku = Post.create(title:"Rails to Heroku: A brief walkthrough for you", slug:"rails-to-heroku-a-brief-walkthrough-for-you-9324c007fd0f", date:DateTime.parse(Time.at(1513884680).strftime('%Y/%m/%d')), claps:8, reading_time:4, author_id:1)
# event_delegation = Post.create(title:"Rails to Heroku: A brief walkthrough for you", slug:"event-delegation-in-javascript-61347d115b33", date: DateTime.parse(Time.at(1513884680).strftime('%Y/%m/%d')), claps:2, reading_time:4, author_id:2)
#
#
# #post_tag... yes this doesn't make sense
# herokuRails = PostTag.create(tag_id:3, post_id:1)
#
# #fan_post
# paul_event_delegation = FanPost.create(fan_id:1, liked_post_id:2)
#
# #seth.authored_posts[0].fans returns the user fan
# #paul.liked_posts returns article user likes


web103017 = ["pawlkris", "sethbarden", "dansbands", "jonwu_", "joshstillman", "ellishim", "c0nniewang", "wassermj", "rochlevi", "katpapacostas", "jakemacnaughton", "erickcodes", "schung97", "corybaker_54290", "gdriza", "yuliyayas", "bmcilhen", "georgelgore"]

web112017 = ["ddbren", "humzah.choudry", "kellydsample", "clergemarvin", "mattcfaircloth", "matt.mcalister93", "alisonmackay246", "yamunanavada"]

web121117 = ["olegchursin", "mautayro", "krandles", "drewovercash", "a.kallenbornbolden", "brianaclairbaker", "jtregoat"]

web0108 = ["alexey.katalkin", "feihafferkamp", "joshdeiner75", "morgannegagne", "tania.e.aparicio", "cristy.lucke", "torre.johnson"]

web0129 = ["aralx73", "diep.christopher", "ichabon", "jairoespinosa95", "melnock", "ryanmarinerfarney"]

co1009 = Cohort.create(name:"10092017", start_date:DateTime.new(2017,10,9))
co1030 = Cohort.create(name:"10302017", start_date:DateTime.new(2017,10,30))
co1120 = Cohort.create(name:"11202017", start_date:DateTime.new(2017,11,20))
co1211 = Cohort.create(name:"12112017", start_date:DateTime.new(2017,12,11))
co0108 = Cohort.create(name:"01082018", start_date:DateTime.new(2018,1,8))
co0129 = Cohort.create(name:"01292018", start_date:DateTime.new(2018,1,8))



def fetch_user(username)
  url = "https://medium.com/@#{username}/latest"
  headers = {Accept:'application/json'}
  response = RestClient.get(url, headers)
  body = response.body
  body = body.sub("])}while(1);</x>","")
  json = JSON.parse(body)
  payload = json["payload"]
end

def read_accounts(mod, userArray)
  #convert cohort start date to miliseconds to filter articles only from beginning of cohort
  cohort_start = Cohort.find(mod).start_date.to_time.to_i*1000
  userArray.each do |username|
    payload = fetch_user(username)

    #add user
    #need to revise to find or create and remove password when used for recurring updates... perhaps just remove user update altogether?
    @user = User.create(medium_username:username, cohort_id:mod, password:username)
    @user.update(name:payload["user"]["name"], image_slug:payload["user"]["imageId"])


    author_id = @user.id
    if payload["references"]["Post"]
    postIds = payload["references"]["Post"].keys
      postIds.each do |post|
        postHash = payload["references"]["Post"][post]
        #check if post was published after cohort start date
        if (postHash["firstPublishedAt"] > cohort_start)
          #find or create Posts
          @post = Post.find_or_create_by(slug:postHash["uniqueSlug"], author_id:author_id)
          @post.update(title:postHash["title"], date:postHash["firstPublishedAt"], claps:postHash["virtuals"]["totalClapCount"], reading_time: postHash["virtuals"]["readingTime"].round)

          #create PostTags
          tagArray = postHash["virtuals"]["tags"]
          tagArray.each do |tag|
            tag_id = Tag.find_or_create_by(name:tag["name"], slug:tag["slug"]).id
            post_tag = PostTag.find_or_create_by(tag_id:tag_id, post_id:@post.id)
          end
        end
      end
    end
  end
end

read_accounts(co1030.id, web103017)

read_accounts(co1120.id, web112017)

read_accounts(co1211.id, web121117)

read_accounts(co0108.id, web0108)

read_accounts(co0129.id, web0129)




FanPost.create(fan_id:1, liked_post_id:30)
FanPost.create(fan_id:1, liked_post_id:18)
FanPost.create(fan_id:1, liked_post_id:42)
FanPost.create(fan_id:1, liked_post_id:7)
FanPost.create(fan_id:4, liked_post_id:12)
FanPost.create(fan_id:4, liked_post_id:13)
FanPost.create(fan_id:4, liked_post_id:67)
FanPost.create(fan_id:4, liked_post_id:99)
FanPost.create(fan_id:2, liked_post_id:72)
FanPost.create(fan_id:2, liked_post_id:55)
FanPost.create(fan_id:2, liked_post_id:83)
FanPost.create(fan_id:2, liked_post_id:19)
