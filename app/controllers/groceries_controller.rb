class GroceriesController < ApplicationController
  before_action :set_household
  # before_action :set_courses, only: [:new]


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

    @meal_ids = @courses.map { |course| course.meal.id }.uniq

    @erecipe_id = @courses.first.erecipe_id
    @recipe = Edamam::EdamamRecipe.find(@erecipe_id)

    console
  end

  def create
    params[:grocery].each do |k, grocery_params|
      Grocery::Importer.create(grocery_params)
    end

    if @glist_count == @new_glist
      meal_ids = params[:meal_ids]
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = "Course successfully added!" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit_multiple
    items = params["product"]
    value = false
    g_ids = []
    items.each do |_k, v|
      n = v["list_add"].to_i
      g_ids.push(v["g_ids"].first) if n == 1
    end

    Grocery.where(id: g_ids).update_all(list_add: value)

    redirect_to groceries_path
  end

  private

  def grocery_params
    params.permit(:household_id, :course_id, :erecipe_id, :erecipe_servings,
                  :name, :category, :quantity, :measurement, :list_add,
                  :base_vol_qty, :base_vol_msr, :base_wgt_qty, :base_wgt_msr )
  end

  def set_household
    @household = Household.find(current_user.household_id)
  end

  # def set_courses
  #   @courses = params[:course_ids].map { |id| Course.find(id.to_i) }
  # end
end
