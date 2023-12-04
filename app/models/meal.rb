class Meal < ApplicationRecord
  belongs_to :menu
  belongs_to :user

  has_many :courses, dependent: :destroy

  validates :meal_type, presence: true

  MEAL_TYPES = [
    "Breakfast",
    "Lunch",
    "Dinner"
  ]

  # def self.meal_types
  #   %w(Breakfast Lunch Dinner)
  # end

  private

end
