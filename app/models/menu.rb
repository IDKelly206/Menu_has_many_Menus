class Menu < ApplicationRecord
  after_create :createMeals

  belongs_to :household

  has_many :meals, dependent: :destroy

  validates :date, presence: true


  private

  def createMeals
    menu_id = Menu.last.id
    household_id = Menu.last.household_id
    user_ids = User.all.where(household_id: household_id).ids
    meal_type = %w(Breakfast Lunch Dinner)
    user_ids.each do |user_id|
      meal_type.each do |meal_type|
        Meal.create!(menu_id: menu_id, user_id: user_id, meal_type: meal_type)
      end
    end
  end

  # Menu.createMeals
  #  create 3 meal types with each user underneath as meals
  #  example: Breakfast  with 2 users


end
