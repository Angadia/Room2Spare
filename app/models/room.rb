class Room < ApplicationRecord
    
    belongs_to :facility
    has_many :availabilities, dependent: :destroy

    # Validations
    validates(:name, presence: true, case_sensitive: false)
    validates(:capacity, presence: true, numericality: { greater_than_or_equal_to: 0 } )
    validates(:area, presence: true)

    # Custom methods
    def self.search_by(search_term)
        where("LOWER(capacity) LIKE :search_term OR LOWER(area) LIKE :search_term OR LOWER(whiteboard == true) LIKE :search_term OR LOWER(whiteboard == true) LIKE :search_term" ), search_term: "%{search_term.downcase}%"
    end

end
