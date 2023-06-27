class MealsController < ApplicationController
  before_action :set_household

  def show
  end

  def new_meal
  end

  def new
    @meal = Meal.new
    @users = User.all.where(household_id: @household)
    @menus = Menu.all.where(household_id: @household)
    @dates =
    @meal_type = %w(Breakfast Lunch Dinner)

  end

  def create
    @menu_ids = params.fetch(:menu_ids, [])
    @user_ids = params.fetch(:user_ids, [])
    @meal_type = params.fetch(:meal_type, "")

    meal_last = Meal.last

    @menu_ids.each do |menu_id|
      menu = Menu.find(menu_id)
      @user_ids.each do |user_id|
        Meal.create!(meal_type: @meal_type, user_id: user_id, menu_id: menu_id)
      end
    end

    if Meal.last.id == meal_last.id
      render :new
    else
      redirect_to menus_path
    end
  end

  private

  def set_household
    @household = current_user.household_id
  end

  def meal_params
    # params(:meals).permit(:meal_type, user_ids: [], menu_ids: [])
    params.require(:meal).permit(:name, user_id: [], menu_id: [])
  end


end
