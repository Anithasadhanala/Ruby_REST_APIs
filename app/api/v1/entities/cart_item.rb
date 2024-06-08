
class V1::Entities::CartItem < Grape::Entity
  expose :id
  expose :product_id
  expose :quantity
  expose :category_id
end

