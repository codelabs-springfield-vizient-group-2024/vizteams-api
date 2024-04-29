class User < ApplicationRecord
    
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :password_confirmation, presence: true
end
