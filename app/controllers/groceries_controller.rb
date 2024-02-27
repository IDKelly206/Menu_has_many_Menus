class GroceriesController < ApplicationController
  before_action :set_household
  before_action :set_menu, only: [:create]
  before_action :set_meal, only: [:create]

  def index
    groceries = Grocery.groceries(@household)
    grocery_list = Grocery.grocery_list(groceries)
    recipe_ids = groceries.map { |g_item| g_item.erecipe_id }.uniq
    @grocery_list = Edamam::EdamamRecipe.grocery_list(recipe_ids:, groceries:, grocery_list:)
    console
  end

  def new
    @grocery = Grocery.new
    @course_ids = params[:course_ids]
    @courses = @course_ids.map { |id| Course.find(id.to_i) }

    if @courses.count == 1
      @course = @courses.first
      @meal = @course.meal
      @menu = @meal.menu
      @erecipe_id = @course.erecipe_id
    else
      user_ids = @courses.map { |c| c.meal.user_id }.uniq
      menu_ids = @courses.map { |c| c.meal.menu_id }.uniq
      meal_type = @courses.map { |c| c.meal.meal_type }.uniq
      @users = user_ids.map { |id| User.find(id) }
      @menus = menu_ids.map { |id| Menu.find(id) }
      @meal_type = meal_type.first
      @erecipe_id = @courses.first.erecipe_id
    end
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
        user_ids = courses.map { |c| c.meal.user_id }.uniq
        menu_ids = courses.map { |c| c.meal.menu_id }.uniq
        meal_type = courses.map { |c| c.meal.meal_type }.uniq.first

        redirect_to planner_meals_path(user_ids: user_ids, menu_ids: menu_ids, meal_type: meal_type),
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

  def multi_edit
    value = false
    @g_ids = params[:g_ids].split

    Grocery.where(id: @g_ids).update_all(list_add: value)

    # courses = params[:course_ids].map { |id| Course.find(id) }
    # courses.each do |c|
    #   c.list_add = false
    #   c.save
    # end

    redirect_to groceries_path
  end

  def update
    courses = params[:course_ids].map { |id| Course.find(id) }
    courses.each do |c|
      c.list_add = false
      c.save
    end

    redirect_to groceries_path
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
    # @menu = @course.meal.menu
  end

  def set_meal
    # @menu.nil? ? @meal = nil : @meal = @menu.meals.find(params[:meal_id])
    # @meal = @menu.meals.find(params[:meal_id])

  end

  def grocery_params
    params.permit(:household_id, :course_id, :erecipe_id, :name, :quantity, :measurement, :category, :list_add)
  end
end
