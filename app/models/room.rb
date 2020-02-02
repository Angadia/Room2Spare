class Room < ApplicationRecord
    # Association
    belongs_to :user
    belongs_to :facility

    has_many :availabilities, dependent: :destroy
   


    #validations
    validates(:name, presence: true, uniqueness: true, case_sensitive: false)
    validates(:capacity, presence: true, numericality: { greater_than_or_equal_to: 0 } )
    validates(:area, presence: true)
   
end
