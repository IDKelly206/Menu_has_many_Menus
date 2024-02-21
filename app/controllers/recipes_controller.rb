class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  before_action :set_meal_types, only: [:index, :recipe_search]
  before_action :set_course_types, only: [:index, :recipe_search]


  def index
    if params[:query].present?
      @recipes = Edamam::EdamamRecipe.search(params[:query], params[:filters])
    else
      @recipes = Edamam::EdamamRecipe.search("pasta", params[:filters])
    end
    console
  end

  def show
    console
  end

  def new
  end

  def recipe_search
    @recipes = Edamam::EdamamRecipe.search(params[:query], params[:filters])

    @title = params["title"]
    params[:course_type].nil? ? @course_type = params[:filters][:dishType] : @course_type = params[:course_type]

    if params["meal_ids"].present?
      @meal_ids = params["meal_ids"]
    elsif params["menu_id"].present?
      @menu = Menu.find(params["menu_id"].to_i)
      @meal = Meal.find(params["meal_id"].to_i)
      @course = @meal.courses.build(course_type: @course_type)
    end
  end

  private
  def set_recipe
    recipe_id = params[:id]
    @recipe = Edamam::EdamamRecipe.find(recipe_id)
  end

  def set_meal_types
    @meal_types = Meal::MEAL_TYPES
  end

  def set_course_types
    @course_types = Course::COURSE_TYPES
  end
end
