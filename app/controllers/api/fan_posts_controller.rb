class Api::FanPostsController < ApplicationController

  def destroy
    @fan_post = FanPost.find(params[:id])
    @fan_post.delete
    render json: {message:"Zap! Deleted Post ID", tripId:@fan_post.id}
  end

  def show
    @fan_post = FanPost.find(params[:id])
    render json: @fan_post, status: 200
  end

  def create
    @fan_post = FanPost.new(fan_post_params)
    @fan_post.save
    render json: @fan_post, status: 201
  end


private

  def fan_post_params
    params.permit(:fan_id, :liked_post_id)
  end

end
