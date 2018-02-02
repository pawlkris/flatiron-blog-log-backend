class Api::AuthController < ApplicationController
  def create
    @user = User.find_by(medium_username: params[:username])
    if @user && @user.authenticate(params[:password])
      render json: {username: @user.medium_username, id:@user.id, token:issue_token(id:@user.id)}
    else
      render json: {error: 'User is invalid'}, status: 401
    end
  end

  def show
    if current_user
      render json: {id: current_user.id, username: current_user.medium_username, token: issue_token({id: current_user.id, username: current_user.medium_username})}
    else
      render json: {error: 'Invalid token'}, status: 401
    end
  end


end
