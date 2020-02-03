class Facility < ApplicationRecord
    #Association
    belongs_to :user
    has_many :rooms, dependent: :destroy


    # Validations
    validates(:name, presence: true, uniqueness: true, case_sensitive: false)
    validates(:description, presence: true)
    validates(:address, presence: true)
    validates(:city, presence: true)
    validates(:contact_number, presence: true)

    # Custom methods
    def self.search_by(search_term)
        where("LOWER(city) LIKE :search_term", search_term: "%#{search_term.downcase}%")
    end

end
