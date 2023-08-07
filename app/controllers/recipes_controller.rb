class RecipesController < ApplicationController

  def index
  end

  def show
    @recipe = Edamam::Erecipe.find(:erecipe_id)
  end

  def new
    # search_results = HTTParty.get("https://api.edamam.com/api/recipes/v2?type=public&q=chicken%20&carrots%20&app_id=bb5e4702&app_key=7cb8c06cdedbc2d089957cc57703423c&mealType=Dinner&imageSize=REGULAR", format: :plain)
    # response = JSON.parse (search_results.body), symbolize_names: true
    # @recipes = response.fetch(:hits)

    @meal_type = %w(Breakfast Lunch Dinner)
    @dish_type = ["Main course", "Side dish", "Desserts"]
    @health = ["vegan", "vegetarian", "paleo"]

    # @response = Edamam::Erecipe.search(params[:query], params[:filters])
    @recipes = Edamam::Erecipe.search(params[:query], params[:filters])
    console

  end
end
