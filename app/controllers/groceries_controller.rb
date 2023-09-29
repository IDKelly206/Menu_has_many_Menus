class GroceriesController < ApplicationController
  before_action :set_household
  before_action :set_menu, only: [:new]
  before_action :set_meal, only: [:new]

  def index
    # show all gList item(s)
    # @groceries = Grocery.all.where('household_id = ?', @household).all


    # dups = names.detect { |n| names.count(n) > 1 }


    # #1 Get list of items names w/o doubles of name...
    #  .where('in_inventory = false').
    # #2 Add quantity for each individual names where measurement == measurement
    # #2b - equalize Inventory measurement with calc. single standard measurement.
    # #3 Create new hash of groceries

    # groceries = menu.groceries

    groceries = Grocery.all.where('household_id = ?', @household).all
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
    # Get last added recipe from course for ingredient items to add in gList
    @erecipe_id = Course.where(meal_id: @meal.id).last.erecipe_id
    @recipe = Edamam::EdamamRecipe.find(@erecipe_id)

    # Send to sessions for re-direct purposes after save
    session[:menu_id] = @menu.id
    session[:meal_id] = @meal.id
    console
  end

  def create
    params[:grocery].each do |k, grocery_params|
      Grocery::Importer.create(grocery_params)
    end

    @menu = session[:menu_id]
    @meal = session[:meal_id]

    if @glist_count == @new_glist
      menu_ids = session[:menu_ids].present? ? session[:menu_ids].map { |n| n.to_i } : ""
      meal_ids = session[:meal_ids].present? ? session[:meal_ids].map { |n| n.to_i } : ""
      if menu_ids.empty? && meal_ids.empty?
        redirect_to menu_meal_path(@menu, @meal), notice: "Grocery items successfully added to Grocery List."
      elsif meal_ids.include?(@meal) && menu_ids.include?(@menu)
        redirect_to new_meal_path, notice: "Grocery items successfully added to Grocery List."
      else
        render :new, status: :unprocessable_entity
      end
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
    @menu = Menu.find(params[:menu_id])
  end

  def set_meal
    @meal = @menu.meals.find(params[:meal_id])
  end

  def grocery_params
    params.permit(:household_id, :erecipe_id, :name, :quantity, :measurement, :category, :list_add)
  end
end
