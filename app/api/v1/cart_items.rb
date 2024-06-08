class V1::CartItems < Grape::API



  before { authenticate_user! }

  resources :cartItems do

    # Endpoint, gives all carts----------------------------------------------------------------------------------------
    desc 'return all cart items'

    params do
      optional :page, type: Integer, default: DEFAULT_PAGE
      optional :per_page, type: Integer, default: DEFAULT_PER_PAGE
    end

    get do
      carts = paginate(Cart.active)
      present carts, with: V1::Entities::CartItem
    end



    # Endpoint to get a specific cartItem by ID-------------------------------------------------------------------------------
    desc 'Return a specific cartItem' do
      success V1::Entities::CartItem
      failure [[404, 'cartItem Not Found'], [500, 'Internal Server Error']]
    end

    params do
      requires :id, type: Integer
    end

    get ':id' do
      cartItem = Cart.find_by(id: params[:id], flag: true)
      if cartItem
        present cartItem, with: V1::Entities::CartItem
      else
        error!({ error: 'cartItem Not Found' }, 404)
      end
    rescue => e # catch like implementation
      error!({ error: e.message }, 500)
    end




    # Endpoint to create a new cartItem---------------------------------------------------------------------------------------
    desc 'Create a new cartItem'do
      success V1::Entities::CreateItem
      failure [422, 'DB not saved']
    end

    params do
      requires :product_id, type: Integer
      requires :category_id, type: Integer
      optional :quantity, type: Integer, default: 1
    end

    post do

      cart_item = Cart.find_by(product_id: params[:product_id],user_id: Current.user.id)

      if cart_item.nil?
        cart_item = Cart.create!(product_id: params[:product_id],user_id: Current.user.id, quantity: params[:quantity], flag: true,category_id:[:category_id])
        present cart_item, with: V1::Entities::CreateItem
      else
        cart_item.update(quantity: params[:quantity])
        message = "Product already exists in the cart. Quantity updated."
        present message: message, cart_item: cart_item
      end
    rescue ActiveRecord::RecordNotFound
      error!({ error: 'Cart not found' }, 404)
    rescue ActiveRecord::RecordInvalid => e
      error!({ error: e.message }, 422)
    end




    # Endpoint for updating a specific cartItem---------------------------------------------------------------------------------
    desc 'Update a cartItem' do
      success V1::Entities::CartItem
      failure [[404, 'Product Not Found'],[422, 'DB not saved']]
    end

    params do
      requires :product_id, type: Integer
      requires :category_id, type: Integer
      optional :quantity, type: Integer, default: 1
    end

    put ':id' do
      cartItem = Cart.find(params[:id])
      error!('cartItem Not Found', 404) unless cartItem

      # Here declared method for filtering the params accordingly
      # include_missing is not taking the params for updating which are not provided
      cartItem.update(declared(params, include_missing: false))
      present cartItem, with: V1::Entities::CartItem

    rescue ActiveRecord::RecordInvalid => e
      error!({ error: e.message }, 422)
    end




    # Endpoint that deletes a specific cartItem----------------------------------------------------------------------------------
    desc 'Delete a cartItem'do
      success [200, 'Hurry!, deleted successfully']
      failure [[404, 'cartItem Not Found'], [500, 'Internal Server Error']]
    end

    params do
      requires :id, type: Integer
    end

    delete ':id' do
      cartItem = Cart.find_by(id: params[:id])
      if cartItem
        cartItem.update(flag: false)
        { message: 'Hurry!, deleted successfully' }
      else
        error!({ error: 'cartItem Not Found' }, 404)
      end
    end
  end
end