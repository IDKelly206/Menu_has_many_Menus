class Course < ApplicationRecord
  belongs_to :meal

  has_many :groceries

  validates :course_type, presence: true
  validates :meal_id, presence: true
end
