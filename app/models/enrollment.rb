class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user

  # A user can be enrolled in a course once at one time
  validates :user_id, uniqueness: { scope: :course_id }
end
