class CoursesController < ApplicationController
  before_action :set_household, except: [:create, :destroy_multiple]
  # before_action :set_meal_types, only: [:new]
  # before_action :set_course_types, only: [:new]
  before_action :set_menu, only: [:destroy]
  before_action :set_meal, only: [:destroy]
  before_action :set_course, only: [:edit, :update, :destroy]
  before_action :set_menus, only: [:multi_destroy]
  before_action :set_users, only: [:multi_destroy]
  before_action :set_meal_type, only: [:multi_destroy]

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

    redirect_to planners_path( user_ids: @users,
                                    menu_ids: @menus,
                                    meal_type: @meal_type ),
                notice: "Courses deleted"
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
