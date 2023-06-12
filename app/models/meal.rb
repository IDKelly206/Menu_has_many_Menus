class Meal < ApplicationRecord
  belongs_to :menu
  belongs_to :user

  has_many :courses

  validates :meal_type, presence: true

end
