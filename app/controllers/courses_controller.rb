class CoursesController < ApplicationController
  before_action :set_household, except: [:create]
  before_action :set_meal_types, only: [:index]
  before_action :set_course_types, only: [:index]
  before_action :set_menu, only: [:destroy]
  before_action :set_meal, only: [:destroy]
  before_action :set_course, only: [:edit, :update, :destroy]

  def index
    course_groups = []
    @meals = params[:meal_ids].map { |id| Meal.find(id) }
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

  end

  def create
    courses = Course::Multicourse.create(course_params)
    @course_ids = courses.map { |course| course.id }
    if @course_count == @new_courses
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = "Course successfully added!" }
      end
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

    redirect_to menu_meal_path(@menu, @meal), notice: "Courses deleted"
  end

  def multi_destroy
    Course.destroy(params[:course_ids])
    # meal_ids = params[:meal_ids]
    # redirect_to planners_path(meal_ids: meal_ids),
    #             notice: "Courses deleted"
    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Course REMOVED added!" }
    end
  end

  private

  def course_params
    params.permit(:course_type, :erecipe_id, meal_ids: [])
  end

  def set_meal_types
    @meal_types = Meal::MEAL_TYPES
  end

  def set_course_types
    @course_types = Course::COURSE_TYPES
  end

  def set_household
    @household = Household.find(current_user.household_id)
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


  # def set_menus
  #   @menus = params[:menu_ids].map { |menu_id| Menu.find(menu_id.to_i) }
  # end

  # def set_users
  #   @users = params[:user_ids].map { |user_id| User.find(user_id.to_i) }
  # end

  # def set_meal_type
  #   @meal_type = params[:meal_type]
  # end
end
