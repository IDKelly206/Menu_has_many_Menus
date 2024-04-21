class GroceriesController < ApplicationController
  before_action :set_household

  def index
    groceries = Grocery.groceries(@household)
    grocery_list = Grocery.grocery_hash(groceries)
    recipe_ids = groceries.map { |g_item| g_item.erecipe_id }.uniq
    @grocery_list = Grocery.grocery_list(groceries:, grocery_list:, recipe_ids:)
    console
  end

  def new
    @grocery = Grocery.new

    @course_ids = params[:course_ids]
    @courses = @course_ids.map { |id| Course.find(id.to_i) }

    user_ids = @courses.map { |c| c.meal.user_id }.uniq
    @users = user_ids.map { |id| User.find(id) }

    menu_ids = @courses.map { |c| c.meal.menu_id }.uniq
    @menus = menu_ids.map { |id| Menu.find(id) }

    meal_type = @courses.map { |c| c.meal.meal_type }.uniq
    @meal_type = meal_type.first

    @erecipe_id = @courses.first.erecipe_id
    @recipe = Edamam::EdamamRecipe.find(@erecipe_id)

    console
  end

  def create
    params[:grocery].each do |k, grocery_params|
      Grocery::Importer.create(grocery_params)
    end

    @course_ids = params[:course_ids].split
    courses = @course_ids.map { |id| Course.find(id) }
    # courses = Course.where(id: params[:course_ids])
    if @glist_count == @new_glist
      user_ids = courses.map { |c| c.meal.user_id }.uniq
      menu_ids = courses.map { |c| c.meal.menu_id }.uniq
      meal_type = courses.map { |c| c.meal.meal_type }.uniq.first
      redirect_to new_planner_path(user_ids: user_ids, menu_ids: menu_ids, meal_type: meal_type),
        notice: "Grocery items successfully added to Grocery List."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def edit_multiple
    value = false
    g_ids = params[:g_ids].first.split
    Grocery.where(id: g_ids).update_all(list_add: value)

    redirect_to groceries_path
  end

  def update
  end

  def destroy
  end

  private

  def set_household
    @household = Household.find(current_user.id)
  end

  def grocery_params
    params.permit(:household_id, :course_id, :erecipe_id, :name, :quantity, :measurement, :category, :list_add)
  end
end
