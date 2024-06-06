class User < ApplicationRecord
    has_secure_password

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
