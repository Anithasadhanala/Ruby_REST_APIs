module PaginationHelper
  def paginate(collection)
    collection.paginate(page: params[:page], per_page: params[:per_page])
  end
end