class GroceriesController < ApplicationController
  before_action :set_household
  before_action :set_menu, only: [:create]
  before_action :set_meal, only: [:create]

  def index
    groceries = Grocery.groceries(@household)
    grocery_list = Grocery.grocery_list(groceries)
    ids = groceries.map { |g_item| g_item.erecipe_id }.uniq
    @grocery_list = Edamam::EdamamRecipe.grocery_list(ids:, groceries:, grocery_list:)
    console
  end

  def new
    @grocery = Grocery.new
    @course_ids = params[:course_ids]
    @courses = @course_ids.map { |course_id| Course.find(course_id.to_i) }

    @course = @courses.first
    @meal = @course.meal
    @menu = @meal.menu

    

    # Need eRecipeID for courses just created for ingredient items to add in gList
    @erecipe_id = @course.erecipe_id
    @recipe = Edamam::EdamamRecipe.find(@erecipe_id)

    console
  end

  def create
    params[:grocery].each do |k, grocery_params|
      Grocery::Importer.create(grocery_params)
    end

    @course_ids = params[:course_ids].split
    courses = @course_ids.map { |id| Course.find(id) }

    if @glist_count == @new_glist
      if courses.size > 1
        user_ids = []
        menu_ids = []
        meal_type = []
        courses.each do |c|
          user_ids << c.meal.user.id
          menu_ids << c.meal.menu.id
          meal_type << c.meal.meal_type
        end
        user_ids = user_ids.uniq
        menu_ids = menu_ids.uniq
        meal_type = meal_type.uniq.first

        redirect_to new_meal_path(user_ids: user_ids, menu_ids: menu_ids, meal_type: meal_type),
                                  notice: "Grocery items successfully added to Grocery List."
      else
        redirect_to menu_meal_path(courses.first.meal.menu, courses.first.meal),
                                  notice: "Grocery items successfully added to Grocery List."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_household
    @household = Household.find(current_user.id)
  end

  def set_menu
    # params[:menu_id].present? ? @menu = Menu.find(params[:menu_id]) : @menu = nil
    # @menu = Menu.find(params[:menu_id])
    @menu = @course.meal.menu
  end

  def set_meal
    # @menu.nil? ? @meal = nil : @meal = @menu.meals.find(params[:meal_id])
    # @meal = @menu.meals.find(params[:meal_id])

  end

  def grocery_params
    params.permit(:household_id, :course_id, :erecipe_id, :name, :quantity, :measurement, :category, :list_add)
  end
end
