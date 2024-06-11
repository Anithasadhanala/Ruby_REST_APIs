module AuthenticationHelper
  def authenticate_user!
    error!('Unauthorized', 401) unless current_user
  end

  def current_user
    header = request.headers['authorization']
    token = header.split(' ').last if header
    return error!('Unauthorized', 401) unless token

    begin
        payload, _header = JWT.decode(token, nil, false)
        if payload['expiry'] && Time.at(payload['expiry']) < Time.now
          return error!('Token has expired', 401)
        end

        # token decoding
        data = JWT.decode(token, "SECRET", true, { algorithm: 'HS256' })

        # Check if the token is blacklisted
        if UserJwtToken.exists?(jwt_token: token, is_active: false)
          error!('Unauthorized', 401)
        else
          Current.user = User.find(data[0]['user_id'])
          @current_jwt_token = token
        end

        rescue JWT::ExpiredSignature
          error!('Token has expired', 401)
        rescue JWT::DecodeError
          error!('Unauthorized', 401)
    end
  end

  def current_jwt_token
    @current_jwt_token
  end
end
