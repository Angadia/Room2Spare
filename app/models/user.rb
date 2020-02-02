class User < ApplicationRecord
    has_many :facilities,  dependent: :destroy
    has_many :enrollments, dependent: :destroy
    has_many :courses
    has_many :courses, through: :enrollments,  dependent:  :destroy


    validates :email, presence: true, uniqueness: true,
    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    validates :first_name, :last_name, :contact_number, presence: true


    has_secure_password

    def full_name
        "#{first_name} #{last_name}".strip.titleize
    end

end

