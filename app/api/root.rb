

class Root < Grape::API
    format :json

    helpers PaginationHelper

    mount V1::Products
    mount V1::Users
    mount V1::Auth
end