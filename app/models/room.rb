class Room < ApplicationRecord
    
    belongs_to :facility
    has_many :availabilities, dependent: :destroy

    # Validations
    validates(:name, presence: true, case_sensitive: false)
    validates(:capacity, presence: true, numericality: { greater_than_or_equal_to: 0 } )
    validates(:area, presence: true)

end
