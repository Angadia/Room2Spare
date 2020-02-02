class Course < ApplicationRecord
  belongs_to :user

  has_many :enrollees, through: :enrollments, source: :user
  has_many :enrollments, dependent: :destroy

  validates :title, uniqueness: { scope: :user_id }
  validates :title, length: { minimum: 5, maximum: 25 }
  validates :description, length: { minimum: 15, maximum: 500 }
  validates :tuition, numericality: { greater_than_or_equal_to: 0 }
  validates :capacity, numericality: { greater_than_or_equal_to: 0 }
end
