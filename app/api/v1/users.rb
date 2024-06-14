class V1::Users < Grape::API
    format :json


    resource :users do

      desc 'Register a new user' do
        success V1::Entities::RegisterUser
        failure [[422, 'Validation Errors']]
      end

      params do
        requires :username, type: String
        requires :email, type: String
        requires :password, type: String
        requires :password_confirmation, type: String
        requires :phone, type: Integer
        optional :age, type: Integer
        optional :gender, type: String
      end

      post :register do
        begin
          user_instance = User.new
          params[:role] = User.roles[:buyer] if User.roles[:buyer]
          user = user_instance.register_user(params)
          present user, with: V1::Entities::User

          rescue ActiveRecord::RecordInvalid => e
            error!({ error: e.record.errors.full_messages }, 422)
        end
      end


    # Login  Endpoint of  a user ------------------------------------------------------------------------------------------------------------------
      desc 'Login user'
      params do
        requires :email, type: String
        requires :password, type: String
      end

      post :login do
        user = User.find_by(email: params[:email])
        user_role = user.role
        if user && user.authenticate(params[:password]) && User.roles[user_role] == User.roles[:buyer]

            # Check for an existing valid JWT token, if exists then check for the unexpired token
            user_jwt_token = UserJwtToken.new
            valid_token = user_jwt_token.get_valid_token(user.id)
            if valid_token
              present({ jwt_token: valid_token.jwt_token, username: user.username, email: user.email }, with: V1::Entities::Login)
            else
              jwt = user_jwt_token.generate_jwt_token_and_store(user.id)
              present({ jwt_token: jwt, username: user.username, email: user.email }, with: V1::Entities::Login)
            end
        else
          error!('Unauthorized', 401)
        end
      end


    #Logout Endpoint of a user -------------------------------------------------------------------------------------------------------------------
    desc  'Logout user'
    before { authenticate_user! }
      delete :logout do
        if Current.user
          header = request.headers['authorization']
          current_jwt_token = header.split(' ').last if header
          jwt_blacklist_record = UserJwtToken.find_by(jwt_token: current_jwt_token)

          if jwt_blacklist_record
            jwt_blacklist_record.update!(is_active: false)
            { message: 'Logout successful' }
          else
            error!('Unauthorized', 401)
          end
        else
          error!('Unauthorized', 401)
        end
      end
    end
end
