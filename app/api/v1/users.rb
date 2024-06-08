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
        user = User.new(username: params[:username], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation],
          phone: params[:phone], age: params[:age], gender: params[:gender])

        if user.save
          present user, with: V1::Entities::RegisterUser
        else
          error!({ error: user.errors.full_messages }, 422)
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
