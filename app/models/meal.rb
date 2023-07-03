class Meal < ApplicationRecord
  belongs_to :menu
  belongs_to :user

  has_many :courses, dependent: :delete

  validates :meal_type, presence: true

end
