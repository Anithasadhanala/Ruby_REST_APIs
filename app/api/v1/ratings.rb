class V1::Ratings < Grape::API
  before { authenticate_user! }

  resources :products do
    route_param :product_id do
      resources :ratings do

        # Endpoint to get all ratings for a product---------------------------------------------------------------------------
        desc 'Return all ratings for a product'
        params do
          optional :page, type: Integer, default: DEFAULT_PAGE, desc: 'Page number for pagination'
          optional :per_page, type: Integer, default: DEFAULT_PER_PAGE, desc: 'Number of ratings per page'
        end

        get do
          ratings = ProductRating.where(product_id: params[:product_id])
          ratings = paginate(ratings)
          present ratings
        end

        # Endpoint to get a specific rating----------------------------------------------------------------------------------
        desc 'Return a specific rating'
        params do
          requires :id, type: Integer
        end

        get ':id' do
          rating = ProductRating.find_by(id: params[:id], product_id: params[:product_id])
          if rating
            present rating
          else
            error!({ error: 'Rating Not Found' }, 404)
          end
        end

        # Endpoint to create a rating-----------------------------------------------------------------------------------------
        desc 'Create a new rating'
        params do
          requires :rating, type: Integer
        end

        post do
          rating = ProductRating.create!(
            product_id: params[:product_id],
            buyer_id: Current.user.id,
            rating: params[:rating]
          )
          present rating
        rescue ActiveRecord::RecordInvalid => e
          error!({ error: e.message }, 422)
        end

        # Endpoint to update a rating------------------------------------------------------------------------------------------------
        desc 'Update a rating'
        params do
          requires :id, type: Integer
          optional :rating, type: Integer
        end

        put ':id' do
          rating = ProductRating.find_by(id: params[:id], product_id: params[:product_id])
          error!('Rating Not Found', 404) unless rating
          rating.update(declared(params, include_missing: false))
          present rating
        rescue ActiveRecord::RecordInvalid => e
          error!({ error: e.message }, 422)
        end
      end
      end
  end
end
