class Cohort < ApplicationRecord
  has_many :users

  def self.fetch_user(username)
    url = "https://medium.com/@#{username}/latest"
    headers = {Accept:'application/json'}
    response = RestClient.get(url, headers)
    body = response.body
    body = body.sub("])}while(1);</x>","")
    json = JSON.parse(body)
    payload = json["payload"]
  end


  def self.medium_update
    self.all.each do |cohort|
      cohort.users.each do |user|
        payload = self.fetch_user(user.medium_username)
        author_id = user.id
        cohort_start = self.find(user.cohort_id).start_date.to_time.to_i*1000
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
  end


end
