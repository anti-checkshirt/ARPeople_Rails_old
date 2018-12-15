class User < ApplicationRecord
    validates :name, presence:true
    validates :email, presence:true, length: {maximum: 255},format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },uniqueness: { case_sensitive: false }
    has_secure_password
    validates :age, presence:true


end
