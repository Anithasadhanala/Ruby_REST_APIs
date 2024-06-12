class User < ApplicationRecord
    has_secure_password

    has_many :addresses
    has_many :carts, foreign_key: :buyer_id
    has_many :orders, foreign_key: :buyer_id
    has_many :product_ratings, foreign_key: :buyer_id
    has_many :product_reviews, foreign_key: :buyer_id
    has_many :products, foreign_key: :seller_id
    has_many :seller_details, foreign_key: :buyer_id
    has_many :user_jwt_tokens
    has_many :user_payment_details
    has_many :deliveries_as_buyer, class_name: 'Delivery', foreign_key: :buyer_id
    has_many :deliveries_as_delivery_user, class_name: 'Delivery', foreign_key: :delivery_user_id
    has_many :delivery_user_details, foreign_key: :delivery_user_id

    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :phone, presence: true

    # custom validations
    validate :complex_password_check
    validate :email_check


    private
    # custom password complexity checker
    def complex_password_check
      return if password.blank?
      unless password.match(/(?=.*[a-z])/) && password.match(/(?=.*[A-Z])/) &&
        password.match(/(?=.*[0-9])/) && password.match(/(?=.*[^A-Za-z0-9])/)
        errors.add :password, 'must include at least one lowercase letter, one uppercase letter, one digit, and one special character'
      end
    end

    # custom email format checker
    def email_check
      return if email.blank?
      unless email.match(/\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/)
        errors.add :email, 'is not a valid email address'
      end
    end
end




