class Api::PostsController < ApplicationController
  def index
    @posts = Post.all
    render json: @posts, status: 200
  end

  def create
    @post = Post.create(user_params)
    render json: @post, status: 201
  end

  def show
    @post = Post.find(params[:id])
    render json: @post, status: 200
  end

end
