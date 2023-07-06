class Course < ApplicationRecord
  belongs_to :meal
  belongs_to :recipe

  validates :course_type, presence: true
end
