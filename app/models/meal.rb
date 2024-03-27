class Meal < ApplicationRecord
  belongs_to :menu
  belongs_to :user

  has_many :courses, dependent: :destroy

  validates :meal_type, presence: true


  MEAL_TYPES = [
    "breakfast",
    "lunch",
    "dinner"
  ]

  def self.meals(attr = {})
    @menus = attr[:menus]
    @users = attr[:users]
    @meal_type = attr[:meal_type]
    meals = []
    @menus.each do |menu|
      @users.each do |user|
        meal = where('user_id = ?', user.id).where('menu_id = ?', menu.id).where('meal_type = ?', @meal_type).ids
        meals.push(meal)
      end
    end
    meals.flatten.map { |meal| Meal.find(meal) }
  end
end
