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


    @g_items = []
    @grocery_items = @recipe.ingredients.each do |i|
      @g_items = Grocery.new(
        household_id: @household,
        name: i['food'],
        quantity: i['quantity'],
        measurement: i['measure'],
        category: i['foodCategory'],
        erecipe_id: i['@recipe.erecipe.id']
      )
    end

    console
  end

  def create

    @menu_id = params[:menu_id]
    @meal_id = params[:meal_id]

    @grocery = Grocery.new(grocery_params)
      redirect_to
    if @grocery.save
      redirect_to menu_meal_path(@menu_id, @meal_id), notice: "Grocery items added"
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
    params.require(:grocery).permit(:household_id, :name, :quantity, :measurement, :category, :erecipe_id)
  end
end
