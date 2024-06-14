class V1::Entities::Login < Grape::Entity
  expose :jwt_token
  expose :username
  expose :email
end