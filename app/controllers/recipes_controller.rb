class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  def index
    if params[:query].present?
      @recipes = Edamam::EdamamRecipe.search(params[:query], params[:filters])
    else
      @recipes = Edamam::EdamamRecipe.search("banana", params[:filters])
    end
    # if turbo_frame_request?
    #   render partial: "recipes", locals: { recipes: @recipes }
    # else
    #   render "index"
    # end

    # render @recipes, partial: 'recipes/recipe'

    console
  end



  def show
    @recipe = Edamam::EdamamRecipe.find(@recipe_id)

    console
  end

  def new

    console
  end

  def recipe_search
    @recipes = Edamam::EdamamRecipe.search(params[:query], params[:filters])

    @title = params["title"]

    if params["meal_ids"].present?
      @meal_ids = params["meal_ids"]
    elsif params["menu"].present?
      @menu = Menu.find(params["menu_id"])
      @meal = Meal.find(params["meal_id"])
      @course = @meal.courses.build
    end
  end

  private
  def set_recipe
    @recipe_id = params[:id]
  end



end
