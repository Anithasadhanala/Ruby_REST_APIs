
class V1::Entities::SingleProduct < Grape::Entity
    expose :id
    expose :name
    expose :price
    expose :description
    expose :category_id
end
     
  