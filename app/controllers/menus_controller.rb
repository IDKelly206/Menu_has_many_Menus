class MenusController < ApplicationController
  before_action :set_household
  before_action :set_users
  before_action :set_menu, only: [:show, :show_meal]
  before_action :set_meal_types, only: [:index, :show, :show_meal]
  before_action :set_course_types, only: [:index, :show, :show_meal]


  def index
    @menus = Menu.create_menus(@household).ordered
    console
  end

  def show
  end

  def show_meal
    @meal_type = params["meal_type"]
    @meals = @menu.meals.where(meal_type: @meal_type)
    @erecipe_ids = @meals.map { |m| m.courses.map { |c| c.erecipe_id } }.flatten.uniq
    @recipes = @erecipe_ids.map { |recipe_id| Edamam::EdamamRecipe.find(recipe_id) }

    console
  end

  def new
  end

  def create
  end

  private
  def set_household
    @household = Household.find(current_user.id)
  end

  def set_meal_types
    @meal_types = Meal::MEAL_TYPES
  end

  def set_course_types
    @course_types = Course::COURSE_TYPES
  end

  def set_users
    @users = @household.users
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end

  def menu_params
    params.require(:menu).permit(:date)
  end
end
