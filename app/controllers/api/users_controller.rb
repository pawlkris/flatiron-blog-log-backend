class Api::UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users, status: 200
  end

  def create
    byebug
    @user = User.new(user_params)
    if @user.valid?
      payload = fetch_user(params[:medium_username])
      @user.update(name:payload["user"]["name"], image_slug:payload["user"]["imageId"])
      author_id = @user.id
      cohort_start = Cohort.find(@user.cohort_id).start_date.to_time.to_i*1000
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
      render json: @user, status: 201
    else
      render json: @user.errors, status: 409
    end

  end

  def show
    @user = User.find(params[:id])
    render json: @user, status: 200
  end

  def update
    @user = User.find(params[:id])
    @user.update(cohort_id:params[:cohort_id], email:params[:email], github:params[:github])
    if params[:password] != ""
      @user.password = params[:password]
      @user.save
    end
    render json: @user, status: 202
  end


private

  def user_params
    params.permit(:name, :medium_username, :github, :email, :password, :cohort_id, :user)
  end

  def fetch_user(username)
    url = "https://medium.com/@#{username}/latest"
    headers = {Accept:'application/json'}
    response = RestClient.get(url, headers)
    body = response.body
    body = body.sub("])}while(1);</x>","")
    json = JSON.parse(body)
    payload = json["payload"]
  end

end
