class Facility < ApplicationRecord
    #Association
    belongs_to :user
    has_many :rooms, dependent: :destroy



    # Validations
    validates(:title, presence: true, uniqueness: true, case_sensitive: false)
    validates(:description, presence: true)
    validates(:address, presence: true)
    validates(:city, presence: true)
    validates(:parking, presence: true)
    validates(:contact_number, presence: true)

end
