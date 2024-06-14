class User < ApplicationRecord
  has_secure_password

  enum role: { buyer: "BUYER", admin: "ADMIN", seller: "SELLER" }

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

  validates_format_of :username, with: /\A[a-zA-Z_-]+\z/, message: "can only contain alphabets, underscores, and dashes"

  # custom validations
  validate :complex_password_check
  validate :email_check

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

  # Callbacks

  def seller?
    role == "seller"
  end

  def create_seller_detail(params,user_id)
    seller_detail = SellerDetail.new(
      buyer_id: user_id,
      store_name: params[:store_name],
      store_license: params[:store_license],
      work_phone: params[:work_phone],
      store_logo: params[:store_logo] || ""
    )
    if seller_detail.save
      seller_detail
    else
      raise ActiveRecord::RecordInvalid.new(seller_detail)
    end
  end

  # registers a new user callback
  def register_user(params)
    user = User.new(
      username: params[:username],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      phone: params[:phone],
      age: params[:age],
      gender: params[:gender],
      role: params[:role]
    )
    if user.save
      create_seller_detail(params,user.id)
      user
    else
      raise ActiveRecord::RecordInvalid.new(user)
    end
  end
end
