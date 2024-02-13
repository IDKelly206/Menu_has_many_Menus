class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

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
    # @course_type = params[:course_type]
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



end
