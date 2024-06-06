class V1::Users < Grape::API
    format :json
    prefix :api
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
    end
  end

