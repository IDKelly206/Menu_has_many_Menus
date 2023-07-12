class RecipesController < ApplicationController
  def index

  end

  def new
    response = HTTParty.get("https://api.edamam.com/api/recipes/v2?type=public&q=chicken%20&app_id=bb5e4702&app_key=7cb8c06cdedbc2d089957cc57703423c&mealType=Dinner&imageSize=REGULAR")
    parsed = JSON.parse(response.body)["hits"]
    
    console
  end
end
