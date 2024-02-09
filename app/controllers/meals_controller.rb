class MealsController < ApplicationController
  before_action :set_household
  before_action :set_menu, only: [:index, :show]
  before_action :set_meal, only: [:index, :show]
  before_action :set_meal_types, only: [:index, :show, :meal_new, :new]
  before_action :set_course_types, only: [:index, :show, :new]
  before_action :set_menus, only: [:new, :destroy]
  before_action :set_users, only: [:new, :destroy]
  before_action :set_meal_type, only: [:new, :destroy]
  before_action :set_meals, only: [:new]
  # before_action :set_course, only: [:new]



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

    @meal_ids = @meals.map { |m| m.id }

    course_groups = []
    @meals.each { |meal| course_groups.push(meal.courses.map { |course| Course.find(course.id) }) }
    @courses_all = course_groups.flatten

    courses_of_meals = {}
    @courses_all.each do |course|
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
    @courses = @recipes_with_course_id.keys.map { |recipe_id| @courses_all.detect { |course| course.erecipe_id == recipe_id } }
    @course_recipes = @courses.map { |course| Edamam::EdamamRecipe.find(course.erecipe_id) }

    console
  end


  def create
    courses = Meal::Multicourse.create(course_params)
    course_ids = courses.map { |course| course.id }
    if @course_count == @new_courses
      redirect_to new_grocery_path(course_ids: course_ids), notice: "Course successfully added"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @courses = @meal.courses
    @recipes = @courses.map { |course| Edamam::EdamamRecipe.find(course.erecipe_id) }

    console
  end

  def multi_destroy
  end

  def destroy
    course_ids = params[:courses]
    Course.where(id: course_ids).destroy_all

    redirect_to new_meal_path( user_ids: @users,
                               menu_ids: @menus,
                               meal_type: @meal_type)
  end

  private

  def set_household
    @household = Household.find(current_user.id)
  end

  def set_menus
    @menus = params[:menu_ids].map { |menu_id| Menu.find(menu_id.to_i) }
  end

  def set_users
    @users = params[:user_ids].map { |user_id| User.find(user_id.to_i) }
  end

  def set_meal_type
    @meal_type = params[:meal_type].capitalize
  end

  def set_meals
    @meals = Meal.meals(menus: @menus, users: @users, meal_type: @meal_type)
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
end
