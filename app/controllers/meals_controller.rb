class MealsController < ApplicationController
  before_action :set_household
  before_action :set_meal_types, only: [:show, :meal_new]
  before_action :set_course_types, only: [:show]
  before_action :set_menu, only: [:show]
  before_action :set_meal, only: [:show]
  before_action :set_user, only: [:show]


  def show
    @courses = @meal.courses
    @recipes = @courses.map { |course| Edamam::EdamamRecipe.find(course.erecipe_id) }

   
  end

  def meal_new
    # Modal of GET form to meal#new. Selects multi-meal criteria
    calendar = (Time.now.to_date...(Time.now.to_date + 10))
    @menus = Menu.where('household_id = ?', @household).where('date IN (:cal)', { cal: calendar })
    @users = @household.users

    @meal = Meal.new

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

  def set_menu
    @menu = Menu.find(params[:menu_id])
  end

  def set_meal
    @meal = @menu.meals.find(params[:id])
  end

  def set_user
    @user = @meal.user
  end
end
