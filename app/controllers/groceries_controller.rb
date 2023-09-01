class GroceriesController < ApplicationController
  before_action :set_household
  before_action :set_menu, only: [:new]
  before_action :set_meal, only: [:new]

  def index
    # show all gList item(s)
    @groceries = Grocery.all.where('household_id = ?', @household).all

    console
  end

  def new
    @grocery = Grocery.new
    # Get last added recipe from course for ingredient items to add in gList
    @erecipe_id = Course.where(meal_id: @meal.id).last.erecipe_id
    @recipe = Edamam::Erecipe.find(@erecipe_id)

    # Send to sessions for re-direct purposes
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
      menu_ids = session[:menu_ids].map { |n| n.to_i }
      if session[:meal_ids].include?(@meal) && menu_ids.include?(@menu)
        redirect_to new_meal_path, notice: "Grocery items successfully added to Grocery List."
      else
        redirect_to menu_meal_path(@menu, @meal), notice: "Grocery items successfully added to Grocery List."
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
  end

  def update
  end

  def destroy
    # remove specific gList itme
  end


  private

  def set_household
    @household = current_user.household_id
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
