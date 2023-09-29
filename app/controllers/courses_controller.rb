class CoursesController < ApplicationController
  before_action :set_household
  before_action :set_menu
  before_action :set_meal
  before_action :set_course, only: [:edit, :update, :destroy]

  def new

    # Search criteria
    @meal_types = ["Breakfast", "Lunch", "Dinner"]
    @dish_type = ["Main course", "Starter", "Desserts"]
    @health = ["vegan", "vegetarian", "paleo"]
    @recipes = Edamam::EdamamRecipe.search(params[:query], params[:filters])

    # Meal ID(s) criteria for multi meal. Set in sessions circular Meal build.
    # Reset due to variable used for multi redirect_to
    session[:menu_ids] = ""
    session[:user_ids] = ""
    session[:meal_type] = ""
    session[:meal_ids] = ""

    @course = @meal.courses.build

    console
  end

  def create
    @course = @meal.courses.build(course_params)

    if @course.save
      redirect_to new_grocery_path(menu_id: params[:menu_id], meal_id: params[:meal_id]),

                  notice: "Course successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # Search criteria
    @meal_type = ["Breakfast", "Lunch", "Dinner"]
    @dish_type = ["Main course", "Starter", "Desserts"]
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
