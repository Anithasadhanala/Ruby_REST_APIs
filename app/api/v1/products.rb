class V1::Products < Grape::API



    before { authenticate_user! }

    resources :products do

        # Endpoint, gives all products----------------------------------------------------------------------------------------
        desc 'Return all products'
        params do
            optional :category_id, type: Integer, desc: 'ID of the category to filter by'
            optional :sort_by, type: String, values: %w[name price], desc: 'Sort by name or price'
            optional :sort_order, type: String, values: %w[asc desc], desc: 'Sort order: ascending or descending'
            optional :search, type: String, desc: 'Search keyword to filter products'
            optional :min_price, type: Float, desc: 'Minimum price for filtering'
            optional :max_price, type: Float, desc: 'Maximum price for filtering'
            optional :color, type: String, desc: 'Color for filtering'
            optional :page, type: Integer, default: DEFAULT_PAGE, desc: 'Page number for pagination'
            optional :per_page, type: Integer, default: DEFAULT_PER_PAGE, desc: 'Number of products per page'
        end

        get do
            products = Product.includes(:category)

            # Filter by category
            products = products.where(category_id: params[:category_id]) if params[:category_id]

            # Sorting
            if params[:sort_by]
                sort_column = params[:sort_by] == 'price' ? 'price' : 'name'
                sort_order = params[:sort_order] == 'desc' ? 'desc' : 'asc'
                products = products.order("#{sort_column} #{sort_order}")
            end

            # Search
            products = products.where('name LIKE ?', "%#{params[:search]}%") if params[:search]

            # Filtering by price range
            products = products.where('price >= ?', params[:min_price]) if params[:min_price]
            products = products.where('price <= ?', params[:max_price]) if params[:max_price]

            # Pagination
            products = paginate(products)

            present products
        end



        # Endpoint to get a specific product by ID-------------------------------------------------------------------------------
        desc 'Return a specific product' do
            success V1::Entities::SingleProduct  
            failure [[404, 'Product Not Found'], [500, 'Internal Server Error']]
        end

        params do
            requires :id, type: Integer
        end

        get ':id' do
            product = Product.find_by(id: params[:id])
        if product
                present product, with: V1::Entities::SingleProduct  
            else
                error!({ error: 'Product Not Found' }, 404)
            end
            rescue => e # catch like implementation
            error!({ error: e.message }, 500)
        end



        
        # Endpoint to create a new product---------------------------------------------------------------------------------------
        desc 'Create a new product'do
            success V1::Entities::CreateItem
            failure [422, 'DB not saved']
        end

        params do
            requires :name, type: String
            requires :price, type: Integer
            requires :description, type: String
            requires :category_id, type: Integer
        end

        post do
            product = Product.create!(name: params[:name],price: params[:price],description: params[:description],category_id: params[:category_id])
            present product, with: V1::Entities::CreateItem
            rescue ActiveRecord::RecordInvalid => e
            error!({ error: e.message }, 422)
        end




        # Endpoint for updating a specific product---------------------------------------------------------------------------------
        desc 'Update a product' do
            success V1::Entities::SingleProduct
            failure [[404, 'Product Not Found'],[422, 'DB not saved']]
        end
    
        params do
            requires :id, type: Integer
            optional :name, type: String
            optional :price, type: Integer
            optional :description, type: String
        end
    
        put ':id' do
            product = Product.find(params[:id])
            error!('Product Not Found', 404) unless product
        
            # Here declared method for filtering the params accordingly
            # include_missing is not taking the params for updating which are not provided
            product.update(declared(params, include_missing: false)) 
            
            present product, with: V1::Entities::SingleProduct
        
            rescue ActiveRecord::RecordInvalid => e
                error!({ error: e.message }, 422)
        end
        

          
        
        # Endpoint that deletes a specific product----------------------------------------------------------------------------------
        desc 'Delete a product'do
            success [200, 'Hurry!, deleted successfully']  
            failure [[404, 'Product Not Found'], [500, 'Internal Server Error']]
        end

        params do
            requires :id, type: Integer
        end

        delete ':id' do
            product = Product.find_by(id: params[:id])
            if product
                product.destroy
                { message: 'Hurry!, deleted successfully' }
            else
                error!({ error: 'Product Not Found' }, 404)
            end
        end
    end
end