class Room < ApplicationRecord
    
    # Call Backs
    before_validation :set_default_value_price
    belongs_to :facility
    has_many :availabilities, dependent: :destroy

    # Validations
    validates(:name, presence: true, case_sensitive: false)
    validates(:capacity, presence: true, numericality: { greater_than_or_equal_to: 0 } )
    validates(:area, presence: true)
    validates(:one_hour_rental_price, presence: true, numericality: { greater_than: 0 })

    # Custom methods
    # def self.search_by(search_term)
    #     where("LOWER(one_hour_rental_price) LIKE :search_term", search_term: "%#{search_term}%")
    # end

    private

    def set_default_value_price
        self.one_hour_rental_price ||= 300
    end


end
