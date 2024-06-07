class V1::Products < Grape::API



    before { authenticate_user! }

    resources :products do

        # Endpoint, gives all products----------------------------------------------------------------------------------------
        desc 'return all products'

        params do
            optional :page, type: Integer, default: DEFAULT_PAGE
            optional :per_page, type: Integer, default: DEFAULT_PER_PAGE
        end

        get do
            products = paginate(Product.all)
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
            success V1::Entities::CreateProduct
            failure [422, 'DB not saved']
        end

        params do
            requires :name, type: String
            requires :price, type: Integer
            requires :description, type: String
        end

        post do
            product = Product.create!(name: params[:name],price: params[:price],description: params[:description])
            present product, with: V1::Entities::CreateProduct
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