class ApplicationController < ActionController::API
  def user_id
    token.first["id"]
  end

  def current_user
    @user ||= User.find_by(id: user_id)
  end

  def token
    begin
          JWT.decode(request.headers['Authorization'], 'secret', true, { :algorithm => 'HS256' })
        rescue JWT::DecodeError
          [{}]
        end
  end

  def issue_token(payload)
    token = JWT.encode(payload, "secret", "HS256")
  end

end
