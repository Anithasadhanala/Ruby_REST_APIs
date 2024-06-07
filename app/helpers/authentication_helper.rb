module AuthenticationHelper
  def authenticate_user!
    error!('Unauthorized', 401) unless current_user
  end

  def current_user
    header = request.headers['authorization']
    token = header.split(' ').last if header
    begin
      data = JWT.decode(token, "SECRET")

      if JwtBlacklist.exists?(jwt_token: token)
        error!('Unauthorized', 401)
      else
        Current.user = User.find(data[0]['user_id'])
        @current_jwt_token = token
      end
    rescue JWT::DecodeError
      error!('Unauthorized', 401)
    end
  end

  def current_jwt_token
    @current_jwt_token
  end
end
