class V1::Drivers < Grape::API
  format :json


  resource :drivers do

    desc 'Register a new driver' do
      success V1::Entities::RegisterUser
      failure [[422, 'Validation Errors']]
    end

    params do
      requires :username, type: String
      requires :email, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
      requires :phone, type: Integer
      requires :vehicle_number,type: String
      requires :delivery_vehicle_id,type: Integer
      requires :salary, type: Float
      requires :delivery_zone_id, type: Integer
      optional :remarks, type: String

    end

    post :register do
      user = User.new(username: params[:username], email: params[:email], password: params[:password],
                      password_confirmation: params[:password_confirmation],
                      phone: params[:phone], age: params[:age], gender: params[:gender],role: User.roles[:seller])

      if user.save
        seller = SellerDetail.new(buyer_id: user.id, store_name: params[:store_name],store_license: params[:store_license],
                                  work_phone:params[:work_phone],store_logo:params[:store_logo],avg_rating: 0.0)
        if seller.save
          present seller
        end
      end
      if !(user.save && seller.save)
        error!({ error: user.errors.full_messages }, 422)
      end
    end





    # Login  Endpoint of  a seller ------------------------------------------------------------------------------------------------------------------
    desc 'Login seller'
    params do
      requires :email, type: String
      requires :password, type: String
    end

    post :login do
      user = User.find_by(email: params[:email])
      user_role = user.role
      if user && user.authenticate(params[:password]) && User.roles[user_role] == User.roles[:seller]

        # Check for an existing valid JWT token, if exists then check for the unexpired token
        existing_tokens = UserJwtToken.where(user_id: user.id).order(created_at: :desc)

        valid_token = existing_tokens.detect do |token|
          begin
            decoded_token = JWT.decode(token.jwt_token, "SECRET", true, algorithm: 'HS256')
            token_expiry = decoded_token[0]['expiry']
            Time.now.to_i < token_expiry && token.is_active == true
          rescue JWT::DecodeError
          end
        end

        if valid_token
          present jwt_token: valid_token.jwt_token, name: user.username, email: user.email
          return
        end

        # Create a new JWT token if no valid existing token is found
        payload = { user_id: user.id, expiry: Time.now.to_i + 360000 }
        jwt = JWT.encode(payload, "SECRET")

        # Create a new UserJwtToken record
        UserJwtToken.create!(user_id: user.id, jwt_token: jwt,is_active: true)

        present jwt_token: jwt, name: user.username, email: user.email
      else
        error!('Unauthorized', 401)
      end
    end






    #Logout Endpoint of a user -------------------------------------------------------------------------------------------------------------------
    desc  'Logout seller'
    before { authenticate_user! }
    delete :logout do
      puts(Current.user)
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
