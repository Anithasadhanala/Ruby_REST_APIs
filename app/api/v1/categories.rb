class V1::Categories < Grape::API



  before { authenticate_user! }

  resources :categories do

    # Endpoint, gives all categories----------------------------------------------------------------------------------------
    desc 'return all categories'

    params do
      optional :page, type: Integer, default: DEFAULT_PAGE
      optional :per_page, type: Integer, default: DEFAULT_PER_PAGE
    end

    get do
      categories = paginate(Category.all)
      present categories
    end



    # Endpoint to get a specific category by ID-------------------------------------------------------------------------------
    desc 'Return a specific product' do
      success V1::Entities::SingleCategory
      failure [[404, 'Category Not Found'], [500, 'Internal Server Error']]
    end

    params do
      requires :id, type: Integer
    end

    get ':id' do
      category = Category.find_by(id: params[:id])
      if category
        present category, with: V1::Entities::SingleCategory
      else
        error!({ error: 'category Not Found' }, 404)
      end
    rescue => e # catch like implementation
      error!({ error: e.message }, 500)
    end




    # Endpoint to create a new category---------------------------------------------------------------------------------------
    desc 'Create a new category'do
      success V1::Entities::CreateItem
      failure [422, 'DB not saved']
    end

    params do
      requires :name, type: String
      requires :description, type: String
    end

    post do
      category = Category.create!(name: params[:name],description: params[:description])
      present category, with: V1::Entities::CreateItem
    rescue ActiveRecord::RecordInvalid => e
      error!({ error: e.message }, 422)
    end




    # Endpoint for updating a specific category---------------------------------------------------------------------------------
    desc 'Update a category' do
      success V1::Entities::SingleCategory
      failure [[404, 'category Not Found'],[422, 'DB not saved']]
    end

    params do
      requires :id, type: Integer
      optional :name, type: String
      optional :description, type: String
    end

    put ':id' do
      category = Category.find(params[:id])
      error!('category Not Found', 404) unless category

      # Here declared method for filtering the params accordingly
      # include_missing is not taking the params for updating which are not provided
      category.update(declared(params, include_missing: false))

      present category, with: V1::Entities::SingleCategory

    rescue ActiveRecord::RecordInvalid => e
      error!({ error: e.message }, 422)
    end



    # Endpoint that deletes a specific category----------------------------------------------------------------------------------
    desc 'Delete a category'do
      success [200, 'Hurry!, deleted successfully']
      failure [[404, 'category Not Found'], [500, 'Internal Server Error']]
    end

    params do
      requires :id, type: Integer
    end

    delete ':id' do
      category = Category.find_by(id: params[:id])
      if category
        category.destroy
        { message: 'Hurry!, deleted successfully' }
      else
        error!({ error: 'category Not Found' }, 404)
      end
    end
  end
end