class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  before_action :set_meal_types, only: [:index, :recipe_search]
  before_action :set_course_types, only: [:index, :recipe_search]


  def index
    if params[:query].present?
      @results = Edamam::EdamamRecipe.search(params[:query], params[:filters])
      if results.instance_of?(Array)
        @recipes = results.first
        @next_page = results.last
      else
        redirect_to root_path, notice: "Recipe API error: " + results
      end
    else
      @results = Edamam::EdamamRecipe.search("hamburger", params[:filters])
      if @results.instance_of?(Array)
        @recipes = @results.first
        @next_page = @results.last
      else
        redirect_to root_path, notice: "Recipe API error: " + @results
      end
    end
    console
  end

  def show
    console
  end

  def new
  end

  def recipe_search
    results = Edamam::EdamamRecipe.search(params[:query], params[:filters])
    if results.instance_of?(Array)
      @recipes = results.first
      @next_page = results.last
    else
      redirect_to root_path, notice: "Recipe API error: " + results
    end

    @title = params["title"]
    params[:course_type].nil? ? @course_type = params[:filters][:dishType] : @course_type = params[:course_type]

    if params["meal_ids"].present?
      @meal_ids = params["meal_ids"]
    elsif params["menu_id"].present?
      @menu = Menu.find(params["menu_id"].to_i)
      @meal = Meal.find(params["meal_id"].to_i)
      params["course_id"].present? ? @course = Course.find(params["course_id"]) : @course = @meal.courses.build
    end
  end

  private

  def set_recipe
    recipe_id = params[:id]
    @result = Edamam::EdamamRecipe.find(recipe_id)
    if @result.instance_of?(Hash)
      @recipe = @result
    else
      redirect_to root_path, notice: "Recipe API error: " + @result
    end
  end

  def set_meal_types
    @meal_types = Meal::MEAL_TYPES
  end

  def set_course_types
    @course_types = Course::COURSE_TYPES
  end
end
