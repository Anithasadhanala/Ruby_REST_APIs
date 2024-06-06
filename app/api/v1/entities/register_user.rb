
class V1::Entities::RegisterUser < Grape::Entity
  expose :id
  expose :username
  expose :email
  expose :phone
  expose :password_digest
end


