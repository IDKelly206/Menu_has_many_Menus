class MealsController < ApplicationController
  before_action :set_household
  before_action :set_menu, only: [:index, :show]
  before_action :set_meal, only: [:index, :show]
  # before_action :set_course, only: [:new]
  before_action :set_meal_types, only: [:index, :show, :meal_new, :new]
  before_action :set_course_types, only: [:index, :show, :new]



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
    @meal_type = params[:meal_type].capitalize
    @meal_ids = meal_ids(@menus, @users, @meal_type)

    @meals = @meal_ids.map { |meal| Meal.find(meal) }
    @meal_count = @meals.size

    courses = []
    @meals.each do |meal|
      course_group = meal.courses.map { |course| Course.find(course.id) }
      courses.push(course_group)
    end
    @courses_all = courses.flatten
    # //////
    courses_of_meal = {}
    @courses_all.each do |course|
      course_id = course.id
      recipe_id = course.erecipe_id
      if courses_of_meal[recipe_id].nil?
        courses_of_meal[recipe_id] = []
        courses_of_meal[recipe_id].push(course_id)
      else
        courses_of_meal[recipe_id].push(course_id)
      end
    end
    @recipes_with_course_id = courses_of_meal.select { |recipe_id, course_ids| course_ids.count == @meal_count }
    # //////
    @recipe_ids_all = @courses_all.map { |course| course.erecipe_id }
    @recipe_ids_uniq = @recipe_ids_all.select { |recipe_id| @recipe_ids_all.count(recipe_id) == @meal_count }.uniq

    @courses = @recipe_ids_uniq.map { |recipe_id| @courses_all.detect { |course| course.erecipe_id == recipe_id } }

    @course_recipes = @courses.map { |course| Edamam::EdamamRecipe.find(course.erecipe_id) }

    console
  end


  def create
    @courses = Meal::Multicourse.create(course_params)
    course_ids = @courses.map { |course| course.id }
    # meal_ids = params[:meal_ids].first.split
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

  def destroy
    course_ids = params[:courses]
    Course.where(id: course_ids).destroy_all

    redirect_to new_meal_path
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

  # def set_course
  #   @course = @meal.courses.find(params[:id])
  # end

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
        meal = Meal.where('user_id = ?', user.id).where('menu_id = ?', menu.id).where('meal_type = ?', meal_type).ids
        meals.push(meal)
      end
    end
    meals.flatten
  end
end
