class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  def index
    # Recipe search criteria
    @meal_types = %w(Breakfast Lunch Dinner)
    @dish_type = ["Main course", "Starter", "Desserts"]
    @health = ["vegan", "vegetarian", "paleo"]

    if params[:query].present?
      @recipes = Edamam::EdamamRecipe.search(params[:query], params[:filters])
    else
      @recipes = Edamam::EdamamRecipe.search("spinach", params[:filters])
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

  private
  def set_recipe
    @recipe_id = params[:id]
  end
end
