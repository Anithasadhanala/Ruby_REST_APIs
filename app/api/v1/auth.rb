
class V1::Auth < Grape::API
    format :json
    prefix :api



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

          payload = { user_id: user.id,  expiry: Time.now.to_i + 4 + 3600  }
          jwt = JWT.encode(payload, "SECRET")

          UserJwtToken.create!(user_id: user.id, jwt_token: jwt)

          present jwt_token: jwt,  name: user.username, email: user.email
        else
          error!('Unauthorized', 401)
        end
      end





      #Logout Endpoint of a user -------------------------------------------------------------------------------------------------------------------
      desc  'Logout user'
        before { authenticate_user! }
          delete :logout do
            puts(Current.user)
            if Current.user
              puts("+++++++++++++++++++++++++++++++++++++++++++")
              header = request.headers['authorization']
              current_jwt_token = header.split(' ').last if header
              JwtBlacklist.create!(jwt_token: current_jwt_token, user_id: Current.user.id)
              { message: 'Logout successful' }
            else
              error!('Unauthorized', 401)
            end
          end

      end
    end

