require  'auth_helper'

class V1::Auth < Grape::API
    format :json
    prefix :api

    helpers AuthHelper

    resource :auth do

      # Login  Endpoint of  a user ------------------------------------------------------------------------------------------------------------------
      desc 'Login user'
      params do
        requires :email, type: String
        requires :password, type: String
      end

      post :login do
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])

          payload = { user_id: user.id }
          access_token = JWT.encode(payload, Rails.application.secrets.secret_key_base)
          puts(Rails.application.secrets.secret_key_base,"*********************************************************************************************")
          token = SecureRandom.uuid
          expiry_time = 7.days.from_now
          refresh_token_obj = UserRefreshToken.create(user: user, refresh_token: token, expiry_time: expiry_time,)

          # setting Cookie for the access_token
          cookies[:access_token] = {
            value: access_token,
            httponly: true,
            secure: Rails.env.production?
          }

          # setting Cookie for the refresh_token
          cookies[:refresh_token] = {
            value: token,
            httponly: true,
            secure: Rails.env.production?
          }
          { message: 'Login successful', access_token: access_token , refresh_token: token }
        else
          error!('Unauthorized', 401)
        end
      end





    # Logout Endpoint of a user -------------------------------------------------------------------------------------------------------------------
      desc 'Logout user'

      delete :logout do
        authenticate_user!
        access_token = cookies[:access_token]
        refresh_token = cookies[:refresh_token]

        # Verify access token
        decoded_token = JWT.decode(access_token, Rails.application.secrets.secret_key_base, algorithm: 'HS256')
        user_id = decoded_token[0]['user_id']


        if user_id == Current.user.id
          if refresh_token.present?
           refresh_token_record = UserRefreshToken.find_by(refresh_token: refresh_token,flag: true)
            if refresh_token_record
              refresh_token_record.update(flag: false)
              cookies.delete(:refresh_token)
              cookies.delete(:access_token)
            end
          end
          { message: 'Logout successful' }
        else
          error!('Unauthorized', 401)
        end
      end


      end







  end

