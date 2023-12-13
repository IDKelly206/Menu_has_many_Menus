class CoursesController < ApplicationController
  before_action :set_household
  before_action :set_menu
  before_action :set_meal
  before_action :set_course, only: [:edit, :update, :destroy]

  def new
    @recipes = Edamam::EdamamRecipe.search(params[:query], params[:filters])

    @course = @meal.courses.build
    @meal_type = @meal.meal_type
    @course_type = params[:course_type]
    @courses = @meal.courses.reject { |course| course if course.id.nil? }
    @course_types = @courses.map { |course| course.course_type }.uniq
    @meal_recipes = @courses.map { |course| Edamam::EdamamRecipe.find(course.erecipe_id) }

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
    @recipes = Edamam::Erecipe.search(params[:query], params[:filters])

    console
  end

  def update
    if @course.update(course_params)
      redirect_to menu_meal_path(@menu, @meal), notice: "Course updated"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy

    redirect_to menu_meal_path(@menu, @meal), notice: "Course deleted"
  end


  private

  def course_params
    params.require(:course).permit(:course_type, :erecipe_id, :meal_id)
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

  def set_course
    @course = @meal.courses.find(params[:id])
  end
end
