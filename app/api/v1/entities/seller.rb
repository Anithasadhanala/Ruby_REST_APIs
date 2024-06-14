class V1::Entities::User < Grape::Entity
  expose :id
  expose :email
  expose :password
  expose :phone
  expose :age
  expose :gender
  expose :store_name
  expose :store_address
  expose :store_license
end
