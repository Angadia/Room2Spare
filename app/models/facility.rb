class Facility < ApplicationRecord
    #Association
    has_many :rooms, dependent: :destroy
end
