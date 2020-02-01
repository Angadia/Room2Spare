class User < ApplicationRecord

    validates :email, presence: true, uniqueness: true,
    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    validates :first_name,     presence: true
    validates :last_name,      presence: true
    validates :contact_number, presence: true 


    has_secure_password
end

