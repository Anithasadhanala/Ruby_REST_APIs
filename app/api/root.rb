class Root < Grape::API
    format :json
    mount V1::Products
    mount V1::Users
end