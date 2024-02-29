class Menu < ApplicationRecord
  after_create :create_menu_meals

  belongs_to :household

  has_many :meals, dependent: :destroy

  validates :date, presence: true

  scope :ordered, -> { order(date: :asc) }


  def day_of_week
    "#{self.date.strftime('%a')}: #{self.date.day.ordinalize}  "
  end

  private

  def create_menu_meals
    menu = self
    household = Household.find(menu.household_id)
    users = household.users
    meal_types = Meal::MEAL_TYPES
    users.each do |user|
      meal_types.each do |meal_type|
        Meal.create!(menu: menu, user: user, meal_type: meal_type)
      end
    end
  end
end
