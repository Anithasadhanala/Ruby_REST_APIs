

class Root < Grape::API
    format :json

    helpers PaginationHelper
    helpers AuthenticationHelper

    mount V1::Products
    mount V1::Users
    mount V1::Sellers
    mount V1::Drivers
    mount V1::Categories
    mount V1::CartItems
    mount V1::Reviews
    mount V1::Ratings
end