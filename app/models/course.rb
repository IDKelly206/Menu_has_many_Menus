class Course < ApplicationRecord
  belongs_to :meal

  validates :course_type, presence: true
  validates :meal_id, presence: true
end
