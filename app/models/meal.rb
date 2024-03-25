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

  def self.meals(meals_params)
    if meals_params[:meal_type].nil? || meals_params[:meal_type].empty?
      render :new, status: :unprocessable_entity
    else
      @meal_type = meals_params[:meal_type]
    end

    if meals_params[:menu_ids].nil? || meals_params[:menu_ids].empty?
      render :new, status: :unprocessable_entity
    else
      @menus = meals_params[:menu_ids].map { |menu_id| Menu.find(menu_id.to_i) }
    end

    if meals_params[:user_ids].nil? || meals_params[:user_ids].empty?
      render :new, status: :unprocessable_entity
    else
      @users = meals_params[:user_ids].map { |user_id| User.find(user_id.to_i) }
    end


    # menus = meals_params[:menu_ids].map { |menu_id| Menu.find(menu_id.to_i) }
    # users = meals_params[:user_ids].map { |user_id| User.find(user_id.to_i) }
    # meal_type = meals_params[:meal_type]
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
