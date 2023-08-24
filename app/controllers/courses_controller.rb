class CoursesController < ApplicationController
  before_action :set_household
  before_action :set_menu
  before_action :set_meal
  before_action :set_course, only: [:edit, :update, :destroy]

  def new
    @course = @meal.courses.build

    @meal_type = ["Breakfast", "Lunch", "Dinner"]
    @dish_type = ["Main course", "Side dish", "Desserts"]
    @health = ["vegan", "vegetarian", "paleo"]

    @recipes = Edamam::Erecipe.search(params[:query], params[:filters])

    console
  end

  def search
    @course = @meal.courses.build

    @meal_type = ["Breakfast", "Lunch", "Dinner"]
    @dish_type = ["Main course", "Side dish", "Desserts"]
    @health = ["vegan", "vegetarian", "paleo"]

    @recipes = Edamam::Erecipe.search(params[:query], params[:filters])
    console
  end

  def create
    @course = @meal.courses.build(course_params)

    if @course.save
      redirect_to menu_meal_path(@menu, @meal), notice: "Course successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

    @meal_type = ["Breakfast", "Lunch", "Dinner"]
    @dish_type = ["Main course", "Side dish", "Desserts"]
    @health = ["vegan", "vegetarian", "paleo"]

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
    @household = current_user.household_id
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
