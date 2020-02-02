class Availability < ApplicationRecord
  # Association
  belongs_to :room

  # Validations
  validates(:start_date, presence: true)
  validates(:end_date, presence: true)
  validates(:start_time, presence: true)
  validates(:end_time, presence: true)
  validates(:one_hour_rental_price, presence: true, numericality: { greater_than: 0 })

  # Call Backs
  before_validation :set_default_value_price

  private

  def set_default_value_price
    self.one_hour_rental_price ||= 1
  end
end
