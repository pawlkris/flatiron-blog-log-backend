class ApplicationController < ActionController::API

  def current_user
    @user ||= User.find_by(id: user_id)
  end

  def user_id
    decoded_token.first['user_id']
  end

  def decoded_token
    begin
       JWT.decode(request.headers['Authorization'], ENV["pusher_secret"])
     rescue JWT::DecodeError
      [{}]
     end
  end
end




  # def user_id
  #   token.first["id"]
  # end
  #
  # def current_user
  #   @user ||= User.find_by(id: user_id)
  # end
  #
  # def token
  #   begin
  #         JWT.decode(request.headers['Authorization'], 'secret', true, { :algorithm => 'HS256' })
  #       rescue JWT::DecodeError
  #         [{}]
  #       end
  # end
  #
  # def issue_token(payload)
  #   token = JWT.encode(payload, "secret", "HS256")
  # end
