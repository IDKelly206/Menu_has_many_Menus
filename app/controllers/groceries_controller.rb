class GroceriesController < ApplicationController
  before_action :set_household

  def index
    # show all gList item(s)
    @groceries = Grocery.all.where('household_id = ?', @household).all

    console
  end

  def new
    # create gList item(s)
    @grocery = Grocery.new
    @erecipe_id = Course.where(meal_id: params[:meal_id]).last.erecipe_id
    @recipe = Edamam::Erecipe.find(@erecipe_id)

    @menu_id = params[:menu_id]
    @meal_id = params[:meal_id]


    @grocery_items = []
    @recipe.ingredients.each do |i|
      @g_items = Grocery.new(
        household_id: @household,
        name: i['food'],
        quantity: i['quantity'],
        measurement: i['measure'],
        category: i['foodCategory'],
        erecipe_id: @recipe.erecipe_id
      )
      @grocery_items.push(@g_items)
    end

    console
  end

  def create

    @menu_id = params[:menu_id]
    @meal_id = params[:meal_id]


    params[:grocery].each do |k, grocery_params|
      Grocery::Importer.create(grocery_params)
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
    params.permit(:household_id, :name, :quantity, :measurement, :category, :erecipe_id)
  end
end
