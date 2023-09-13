class MealsController < ApplicationController
  before_action :set_household
  before_action :set_menu, only: [:index, :show]
  before_action :set_meal, only: [:index, :show]



  def meal_new
    # Modal of GET form to meal#new. Selects multi-meal criteria
    calendar = (Time.now.to_date...(Time.now.to_date+10))
    @menus = Menu.where('household_id = ?', @household).where('date IN (:cal)', { cal: calendar })
    @users = @household.users
    @meal_types = %w(Breakfast Lunch Dinner)

    console
  end

  def new
    # Search criteria
    @meal_types = %w(Breakfast Lunch Dinner)
    @dish_type = ["Main course", "Starter", "Desserts"]
    @health = ["vegan", "vegetarian", "paleo"]
    @recipes = Edamam::Erecipe.search(params[:query], params[:filters])

    # Meal ID(s) criteria to specify meal. Set in sessions circular Meal build.
    # Necessary b/c params disappear on Search submit
    session[:menu_ids] = params.fetch(:menu_ids, []) if params.fetch(:menu_ids, []).present?
    session[:user_ids] = params.fetch(:user_ids, []) if params.fetch(:user_ids, []).present?
    session[:meal_type] = params.fetch(:meal_types, "") if params.fetch(:meal_types, []).present?
    # Set meal id criteria as instance variable for display on view
    @menu_ids = session[:menu_ids]
    @user_ids = session[:user_ids]
    @meal_type = session[:meal_type]
    # Used to create multiple courses & provide erecipe_id for groceries
    @meals = []
    @menu_ids.each do |menu_id|
      @user_ids.each do |user_id|
        meal_type = @meal_type
        meal = Meal.where('user_id = ?', user_id).where('menu_id = ?', menu_id).where('meal_type = ?', meal_type).ids
        @meals.push(meal)
      end
    end
    @meals = @meals.flatten!
    session[:meal_ids] = @meals

    console
  end


  def create
    Meal::Multicourse.create(course_params)

    if @course_count == @new_courses
      # redirect_to new_meal_path, notice: "Course was successfully created."
      redirect_to new_grocery_path(meal_id: session[:meal_ids].last, menu_id: session[:menu_ids].last), notice: "Course successfully added"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @courses = @meal.courses

    console
  end

  private

  def set_household
    @household = Household.find(current_user.id)
  end

  def set_menu
    @menu = Menu.find(params[:menu_id])
  end

  def set_meal
    @meal = @menu.meals.find(params[:id])
  end

  def course_params
    params.permit(:course_type, :erecipe_id, meal_ids: [])
  end
end
