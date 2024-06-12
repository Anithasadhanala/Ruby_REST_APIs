
  class V1::Reviews < Grape::API
    before { authenticate_user! }

    resources :products do
      route_param :product_id do
        resources :reviews do

          # Endpoint to get all reviews for a product-------------------------------------------------------------------------
          desc 'Return all reviews for a product'

          params do
            optional :page, type: Integer, default: DEFAULT_PAGE, desc: 'Page number for pagination'
            optional :per_page, type: Integer, default: DEFAULT_PER_PAGE, desc: 'Number of products per page'
          end

          get do
            reviews = ProductReview.where(product_id: params[:product_id],is_deleted: false)
            reviews = paginate(reviews)
            present reviews
          end

          # Endpoint to get a specific review-------------------------------------------------------------------------------------
          desc 'Return a specific review'
          params do
            requires :id, type: Integer
          end
          get ':id' do
            review = ProductReview.find_by(id: params[:id], product_id: params[:product_id],is_deleted: false)
            if review
              present review
            else
              error!({ error: 'Review Not Found' }, 404)
            end
          end

          # Endpoint to create a review-------------------------------------------------------------------------------------------
          desc 'Create a new review'
          params do
            requires :review, type: String
          end
          post do
            review = ProductReview.create!(
              product_id: params[:product_id],
              buyer_id: Current.user.id,
              review: params[:review],

            )
            present review
          rescue ActiveRecord::RecordInvalid => e
            error!({ error: e.message }, 422)
          end

          # Endpoint to update a review-----------------------------------------------------------------------------------
          desc 'Update a review'
          params do
            requires :id, type: Integer
            optional :rating, type: Integer
            optional :comment, type: String
          end
          put ':id' do
            review = Review.find_by(id: params[:id], product_id: params[:product_id],is_deleted: false)
            error!('Review Not Found', 404) unless review
            review.update(declared(params, include_missing: false))
            present review, with: V1::Entities::Review
          rescue ActiveRecord::RecordInvalid => e
            error!({ error: e.message }, 422)
          end

          # Endpoint to delete a review--------------------------------------------------------------------------------------------
          desc 'Delete a review'
          params do
            requires :id, type: Integer
          end
          delete ':id' do
            review = ProductReview.find_by(id: params[:id], product_id: params[:product_id],is_deleted: false)
            if review
              review.update(is_deleted: true)
              { message: 'Review deleted successfully' }
            else
              error!({ error: 'Review Not Found' }, 404)
            end
          end
        end
      end
    end
  end

