module  AuthHelper
  def authenticate_user!
    error!('Unauthorized', 401) unless current_user
  end

  def current_user
    access_token = cookies[:access_token]

    if access_token.present?
      decoded_token = JWT.decode(access_token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      user_id = decoded_token[0]['user_id']

      @current_user ||= User.find_by(id: user_id)
      Current.user = @current_user
    end
  end

end