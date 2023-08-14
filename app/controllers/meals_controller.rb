class MealsController < ApplicationController
  before_action :set_household
  before_action :set_menu, only: [:show]
  before_action :set_meal, only: [:show]


  def show
    console
  end

  def new
    @users = User.all.where(household_id: @household)
    @menus = Menu.all.where(household_id: @household)
    @meal_type = %w(Breakfast Lunch Dinner)
    @meal = Meal.new
  end

  def create
    Meal::Importer.create(meal_params)

    if @meal_count == @new_meals
      redirect_to menus_path, notice: "Meal(s) were successfully created."
    else
      render :new, status: :unprocessable_entity
    end

  end

  private

  def set_household
    @household = current_user.household_id
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end

  def set_meal
    @meal = @menu.meals.find(params[:id])
  end


  def meal_params
    params.permit(:meal_type, user_ids: [], menu_ids: [])
  end
end


#  MEAL creation function with COURSE
# menu_ids.each do |menu_id|
#   menu = Menu.find(menu_id)
#     user_ids.each do |user_id|
#       Meal.create!(meal_type: meal_type, user_id: user_id, menu_id: menu_id)
#       meal_id = Meal.last.id
#       courses_info.each do |course|
#         Course.create!(meal_id: meal_id, course_type: course[0], recipe_id: course[1])
#       end
#     end
# end
#
