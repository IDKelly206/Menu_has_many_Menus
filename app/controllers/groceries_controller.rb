class GroceriesController < ApplicationController
  before_action :set_household
  before_action :set_menu, only: [:new, :create]
  before_action :set_meal, only: [:new, :create]
  before_action :set_course, only: [:new, :create]

  def index
    groceries_all = Grocery.all.where('household_id = ?', @household)
    list_add_true = groceries_all.where('list_add = ?', true)
    names_uniq = list_add_true.map { |i| i.name }.uniq.sort_by!{ |n| n.downcase }
    # All uniq recipe_ids for uncollected grocery items
    @recipe_ids_all = list_add_true.map { |i| i.erecipe_id }
    recipe_ids = @recipe_ids_all.uniq

    g_list = []
    recipe_ids.each do |recipe_id|
      @recipe = Edamam::EdamamRecipe.find(recipe_id)
      @num_of_courses = @recipe_ids_all.count(recipe_id) / @recipe.ingredients.count.to_f
      @servings = @recipe.yield.to_f
      @multiplier = (@num_of_courses / @servings).ceil
      # Go through each unique ingredient name
      names_uniq.each_with_index do |name, index|
        # Determine if a Grocery item exists with a given name and erecipe_id
        unless list_add_true.detect { |g_item| g_item.name == name && g_item.erecipe_id == recipe_id }.nil?
          @g_item = list_add_true.detect { |g_item| g_item.name == name && g_item.erecipe_id == recipe_id }
          # Does the array already have an index assisgned for the unique ingredient name?
          if g_list[index].nil?
            g_list[index] = {}
            g_list[index][:n] = @g_item.name
            g_list[index][:q] = (@g_item.quantity * @multiplier)
            # Need to convert measurement
            g_list[index][:m] = @g_item.measurement
            g_list[index][:cat] = @g_item.category
          else
            g_list[index][:q] += (@g_item.quantity * @multiplier)
          end
        end
      end
    end
    @groceries = g_list.sort_by { |gItem| gItem[:cat] }

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
