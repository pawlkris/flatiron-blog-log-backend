class Api::AuthController < ApplicationController
  def create
  user = User.find_by(medium_username: params[:username])
  if user && user.authenticate(params[:password])
    render json: {
      id: user.id,
      username: user.medium_username,
      jwt: JWT.encode({user_id: user.id}, ENV["pusher_secret"], 'HS256')
    }
  elsif user
    render json: {error: 'Password incorrect. Please try again.'}, status: 404
  else
    render json: {error: 'User not found. Please revise Medium Username.'}, status: 404
  end
end

def show
  if current_user
    render json: {
      id: current_user.id,
      username: current_user.medium_username
    }
  else
    render json: {error: 'No id present on headers'}, status: 404
  end
end

end


# def create
#   @user = User.find_by(medium_username: params[:username])
#   if @user && @user.authenticate(params[:password])
#     render json: {username: @user.medium_username, id:@user.id, token:issue_token(id:@user.id)}
#   else
#     render json: {error: 'User is invalid'}, status: 401
#   end
# end
#
# def show
#   if current_user
#     render json: {id: current_user.id, username: current_user.medium_username, token: issue_token({id: current_user.id, username: current_user.mediumusername})}
#   else
#     render json: {error: 'Invalid token'}, status: 401
#   end
# end
