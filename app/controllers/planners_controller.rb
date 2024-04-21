class PlannersController < ApplicationController
  before_action :set_household
  before_action :set_meal_types
  before_action :set_course_types
  before_action :set_meal_type, only: [:new]
  before_action :set_course_type, only: [:new]
  before_action :set_menus, only: [:new]
  before_action :set_users, only: [:new]

  def new
    @meals = Meal.meals(menus: @menus, users: @users, meal_type: @meal_type)
    @meal_ids = @meals.map { |m| m.id }
    @dietary_restrictions = @users.map { |u| u.dietary_restrictions }.flatten.map { |dr| dr.health.parameter }.uniq


    # s = { query: ["egg"], filters: { mealType: 'lunch', dishType: 'main course' } }
    # @results = Edamam::EdamamRecipe.search(s[:query], s[:filters])
    # if @results.instance_of?(Array)
    #   @recipes = @results.first
    #   @next_page = @results.last

    # else
    #   redirect_to root_path, notice: "Recipe API error: " + @results
    # end
    @recipes = []


    #  FORM object


    #  For rendering course cards in search bar for meals selected
    course_groups = []
    @meals.each { |meal| course_groups.push(meal.courses.map { |course| Course.find(course.id) }) }
    courses_all = course_groups.flatten
    courses_of_meals = {}
    courses_all.each do |course|
      course_id = course.id
      recipe_id = course.erecipe_id
      if courses_of_meals[recipe_id].nil?
        courses_of_meals[recipe_id] = []
        courses_of_meals[recipe_id].push(course_id)
      else
        courses_of_meals[recipe_id].push(course_id)
      end
    end
    courses_of_meals
    @recipes_with_course_id = courses_of_meals.select { |recipe_id, course_ids| course_ids.count == @meals.size }
    @courses = @recipes_with_course_id.keys.map { |recipe_id| courses_all.detect { |course| course.erecipe_id == recipe_id } }
    @course_recipes = @courses.map { |course| Edamam::EdamamRecipe.find(course.erecipe_id) }

    console
  end

  private

  def set_household
    @household = Household.find(current_user.id)
  end

  def set_meal_types
    @meal_types = Meal::MEAL_TYPES
  end

  def set_course_types
    @course_types = Course::COURSE_TYPES
  end

  def set_meal_type
    if params[:meal_type].nil? || params[:meal_type].empty?
      redirect_to meal_new_meals_path, notice: "Select a Meal Type"
    else
      @meal_type = params[:meal_type]
    end
  end

  def set_course_type
    if params[:meal_type].nil? || params[:meal_type].empty?
      redirect_to meal_new_meals_path, notice: "Select a Meal Type"
    else
      @course_type = params[:course_type]
    end
  end

  def set_users
    if params[:user_ids].nil? || params[:user_ids].empty?
      redirect_to meal_new_meals_path, notice: "Select Diner(s)"
    else
      @users = params[:user_ids].map { |user_id| User.find(user_id.to_i) }
    end
  end

  def set_menus
    if params[:menu_ids].nil? || params[:menu_ids].empty?
      redirect_to meal_new_meals_path, notice: "Select Date(s)"
    else
      @menus = params[:menu_ids].map { |menu_id| Menu.find(menu_id.to_i) }
    end
  end
end
