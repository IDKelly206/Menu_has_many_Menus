class GroceriesController < ApplicationController
  before_action :set_household
  before_action :set_menu, only: [:new, :create]
  before_action :set_meal, only: [:new, :create]
  before_action :set_course, only: [:new, :create]

  def index

    groceries = Grocery.select { |g_item| g_item.household_id = @household && g_item.list_add == true }

    ingredient_names = groceries.map { | g_item | g_item.name.singularize.downcase }.uniq
    grocery_list_names = []
    ingredient_names.each_with_index do |name, index|
      grocery_list_names[index] = {}
      grocery_list_names[index][:n] = name.singularize.downcase
    end
    grocery_list = grocery_list_names

    uniq_recipe_ids = groceries.map { |g_item| g_item.erecipe_id }.uniq
    recipes = []
    uniq_recipe_ids.each do |recipe_id|
      recipe = Edamam::EdamamRecipe.find(recipe_id)
      recipes << recipe
    end

    recipes.each do |recipe|
      g_items_per_recipe = groceries.select { |g_item| g_item.erecipe_id == recipe.erecipe_id }.count
      # @g_items_per_recipe = g_items_per_recipe # Number of grocery items for specific recipe
      number_ingredients = 0
      recipe.ingredients.each do |i|
        if ingredient_names.include?(i["food"].singularize.downcase)
          number_ingredients += 1
        else
          number_ingredients += 0
        end
      end
      number_ingredients.to_f

      number_courses_per_recipe = (g_items_per_recipe / number_ingredients)
      servings = recipe.yield.to_f
      ingredient_multiplier = (number_courses_per_recipe / servings).ceil

      recipe.ingredients.each do |ingredient|
        name = ingredient["food"].singularize.downcase
        unless grocery_list.detect { |item| item[:n] == name }.nil?
          g_item = grocery_list.detect { |item| item[:n] == name }
          g_item[:m] = ingredient["measure"] if g_item[:m].nil?
          g_item[:q].nil? ? g_item[:q] = (ingredient["quantity"] * ingredient_multiplier) : g_item[:q] += (ingredient["quantity"] * ingredient_multiplier)
          g_item[:cat] = ingredient["foodCategory"] if g_item[:cat].nil?
        end
      end
    end

    @grocery_list = grocery_list
    console
  end

  def new
    @grocery = Grocery.new
    # Need eRecipeID for courses just created for ingredient items to add in gList
    @course_ids = params[:course_ids]
    @courses = @course_ids.map { |course_id| Course.find(course_id.to_i) }

    @course = @courses.first

    @erecipe_id = @course.erecipe_id
    @recipe = Edamam::EdamamRecipe.find(@erecipe_id)
    # Calculate quantity of ingreients necessary per recipe.
    # Calc based off servings/yield divided by # courses per meal_type multiplied by # menu.dates

    console
  end

  def create
    params[:grocery].each do |k, grocery_params|
      Grocery::Importer.create(grocery_params)
    end
    @course_ids = params[:course_ids].split

    if @glist_count == @new_glist
      if @course_ids.size > 1

        user_ids = []
        menu_ids = []
        meal_types = []

        @course_ids.each do |course_id|
          course = Course.find(course_id.to_i)
          user_ids << course.meal.user.id
          menu_ids << course.meal.menu.id
          meal_types << course.meal.meal_type
        end

        redirect_to new_meal_path(user_ids: user_ids.uniq, menu_ids: menu_ids.uniq, meal_type: meal_types.uniq.first),
                                  notice: "Grocery items successfully added to Grocery List."
      else
        @course = Course.find(@course_ids.first.to_i)
        redirect_to menu_meal_path(@course.meal.menu, @course.meal), notice: "Grocery items successfully added to Grocery List."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # show specific gList item
  end

  def edit
    # update specific gList item

    # gh repo create planner_v2 --private --source=. --remote=upstream
  end

  def update
  end

  def destroy
    # remove specific gList itme
  end

  private
  def set_household
    @household = Household.find(current_user.id)
  end

  def set_menu
    params[:menu_id].present? ? @menu = Menu.find(params[:menu_id]) : @menu = nil
    # @menu = Menu.find(params[:menu_id])
  end

  def set_meal
    @menu.nil? ? @meal = nil : @meal = @menu.meals.find(params[:meal_id])
    # @meal = @menu.meals.find(params[:meal_id])
  end

  def set_course
    # @course = Course.where(meal_id: @meal.id).last
  end

  def grocery_params
    params.permit(:household_id, :course_id, :erecipe_id, :name, :quantity, :measurement, :category, :list_add)
  end
end
