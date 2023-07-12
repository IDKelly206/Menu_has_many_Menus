class RecipesController < ApplicationController

  require "json"
  require "rest-client"


  def index

  end

  def new
    search_results = HTTParty.get("https://api.edamam.com/api/recipes/v2?type=public&q=chicken%20&app_id=bb5e4702&app_key=7cb8c06cdedbc2d089957cc57703423c&mealType=Dinner&imageSize=REGULAR")
    @recipes = JSON.parse(search_results.body)["hits"]

  end
end
