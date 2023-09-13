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

  #  seperate out code so that is enacted after_create on User too
  #  also, @meal_type is defined many places. what is better place to define?

  def create_menu_meals
    menu = self
    household = Household.find(menu.household_id)
    users = household.users
    meal_types = %w(Breakfast Lunch Dinner)
    users.each do |user|
      meal_types.each do |meal_type|
        Meal.create!(menu_id: menu.id, user_id: user.id, meal_type: meal_type)
      end
    end
  end

end
