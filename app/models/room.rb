class Room < ApplicationRecord
    # Association
    belongs_to :facility

    has_many :availabilities, dependent: :destroy
   


    #validations
    validates(:name, presence: true, case_sensitive: false)
    validates(:capacity, presence: true )
    validates(:area, presence: true)
   
end
