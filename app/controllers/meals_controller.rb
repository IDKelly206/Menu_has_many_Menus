class MealsController < ApplicationController
  before_action :set_household
  before_action :set_menu, only: [:index, :show]
  before_action :set_meal, only: [:index, :show]
  before_action :set_meal_types, only: [:index, :show, :meal_new, :new]
  before_action :set_course_types, only: [:index, :show]



  def meal_new
    # Modal of GET form to meal#new. Selects multi-meal criteria
    calendar = (Time.now.to_date...(Time.now.to_date+10))
    @menus = Menu.where('household_id = ?', @household).where('date IN (:cal)', { cal: calendar })
    @users = @household.users

    @meal = Meal.new
    console
  end

  def new
    @recipes = Edamam::EdamamRecipe.search(params[:query], params[:filters])

    # Used to create multiple courses & provide erecipe_id for groceries
    @menus = params[:menu_ids].map { |menu_id| Menu.find(menu_id.to_i) }
    @users = params[:user_ids].map { |user_id| User.find(user_id.to_i) }
    @meal_type = params[:meal_types]
    @meals = meal_ids(@menus, @users, @meal_type)

    console
  end


  def create
    @courses = Meal::Multicourse.create(course_params)
    course_ids = @courses.map { |course| course.id }
    meal_ids = params[:meal_ids].first.split
    if @course_count == @new_courses
      redirect_to new_grocery_path(course_ids: course_ids), notice: "Course successfully added"
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

  def set_meal_types
    @meal_types = Meal::MEAL_TYPES
  end

  def set_course_types
    @course_types = Course::COURSE_TYPES
  end

  def course_params
    params.permit(:course_type, :erecipe_id, meal_ids: [])
  end

  def meal_ids(menus, users, meal_type)
    meals = []
    menus.each do |menu|
      users.each do |user|
        meal = Meal.where('user_id = ?', user.id).where('menu_id = ?', menu.id).where('meal_type = ?', meal_type.capitalize).ids
        meals.push(meal)
      end
    end
    meals.flatten
  end
end
