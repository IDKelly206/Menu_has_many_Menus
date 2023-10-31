class GroceriesController < ApplicationController
  before_action :set_household
  before_action :set_menu, only: [:new, :create]
  before_action :set_meal, only: [:new, :create]
  before_action :set_course, only: [:new, :create]

  def index
    # show all gList item(s)
    # @groceries = Grocery.all.where('household_id = ?', @household).all

    # #1 - Get list of items names w/o doubles of name...
    #      .where('in_inventory = false').
    # #2a - Calculate Q by # course.where(erecipe_id) > Recipe(ercipe.id).servings
    # #2b - Add quantity for each individual names where measurement == measurement
    # #2c - equalize Inventory measurement with calc. single standard measurement.
    # #3 -Create new hash of groceries

    # groceries = menu.groceries

    groceries = Grocery.all.where('household_id = ?', @household)
    names_uniq = groceries.map{ |i| i.name }.uniq
    g_list = []
    @count = 0

    names_uniq.each_with_index do |name, index|
      g_list[index] = {}
      @quantity = 0
      groceries.where(name: name).each do |g_item|
        g_list[index][:n] = name
        @quantity += g_item.quantity
        g_list[index][:q] = @quantity
        g_list[index][:m] = g_item.measurement
        g_list[index][:cat] = g_item.category
      end
      @count += 1
    end

    @groceries = g_list
      # g_list
      # Inject g_list hash into inventory form &
      # Change g_item.in_inventory to true OR delete g_item


      ##2b - Create helper calc to convert any measurement into Inventory standard
      # Use 'ruby-units' gem

    console
  end

  def new
    @grocery = Grocery.new
    # Need eRecipeID for courses just created for ingredient items to add in gList
    @course_ids = params[:course_ids]
    @courses = @course_ids.map { |course_id| Course.find(course_id.to_i) }

    @course = @courses.first

    @erecipe_id = @courses.first.erecipe_id
    @recipe = Edamam::EdamamRecipe.find(@erecipe_id)

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

        redirect_to new_meal_path(user_ids: user_ids.uniq, menu_ids: menu_ids.uniq, meal_types: meal_types.uniq.first),
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

  # Course can not just take last. Multi-course create requires different
  # b/c dependent-destroy correlation with course
  def set_course
    # @course = Course.where(meal_id: @meal.id).last
  end

  def grocery_params
    params.permit(:household_id, :course_id, :erecipe_id, :name, :quantity, :measurement, :category, :list_add)
  end
end
