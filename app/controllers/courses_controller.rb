class CoursesController < ApplicationController
  before_action :set_household, except: [:destroy_multiple]
  before_action :set_meal_types, only: [:new]
  before_action :set_course_types, only: [:new]
  before_action :set_menu, except: [:destroy_multiple]
  before_action :set_meal, except: [:destroy_multiple]
  before_action :set_user, except: [:destroy_multiple]
  before_action :set_course, only: [:edit, :update, :destroy]
  before_action :set_menus, only: [:destroy_multiple]
  before_action :set_users, only: [:destroy_multiple]
  before_action :set_meal_type, only: [:destroy_multiple]


  def new
    if params[:query].present?
      @recipes = Edamam::EdamamRecipe.search(params[:query], params[:filters])
    else
      @recipes = Edamam::EdamamRecipe.search("pasta", params[:filters])
    end

    params[:course_type].nil? ? @course_type = params[:filters][:dishType] : @course_type = params[:course_type]

    @course = @meal.courses.build(course_type: @course_type)
    @meal_type = @meal.meal_type

    # For rendering course cards in search bar for meals selected
    # @courses = @meal.courses.reject { |course| course if course.id.nil? }
    # @course_types = @courses.map { |course| course.course_type }.uniq
    # @meal_recipes = @courses.map { |course| Edamam::EdamamRecipe.find(course.erecipe_id) }

    console
  end

  def create
    @course = @meal.courses.build(course_params)
    if @course.save
      redirect_to new_grocery_path(course_ids: [@course.id]),
                  notice: "Course successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    if params[:query].present?
      @recipes = Edamam::EdamamRecipe.search(params[:query], params[:filters])
    else
      @recipes = Edamam::EdamamRecipe.search("pasta", params[:filters])
    end

    @meal_type = @meal.meal_type
    @course_type = @course.course_type
    console
  end

  def update
    if @course.update(course_params)
      @course.groceries.delete_all
      redirect_to new_grocery_path(course_ids: [@course.id]),
                  notice: "Course successfully updated"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy

    redirect_to menu_meal_path(@menu, @meal), notice: "Course deleted"
  end

  def destroy_multiple
    Course.destroy(params[:course_ids])

    redirect_to planner_meals_path( user_ids: @users,
                               menu_ids: @menus,
                               meal_type: @meal_type)
  end

  private

  def course_params
    params.require(:course).permit(:course_type, :erecipe_id, :meal_id)
  end

  def set_meal_types
    @meal_types = Meal::MEAL_TYPES
  end

  def set_course_types
    @course_types = Course::COURSE_TYPES
  end

  def set_household
    @household = Household.find(current_user.id)
  end

  def set_menu
    @menu = Menu.find(params[:menu_id])
  end

  def set_meal
    @meal = @menu.meals.find(params[:meal_id])
  end

  def set_user
    @user = @meal.user
  end

  def set_course
    @course = @meal.courses.find(params[:id])
  end

  def set_menus
    @menus = params[:menu_ids].map { |menu_id| Menu.find(menu_id.to_i) }
  end

  def set_users
    @users = params[:user_ids].map { |user_id| User.find(user_id.to_i) }
  end

  def set_meal_type
    @meal_type = params[:meal_type]
  end
end
