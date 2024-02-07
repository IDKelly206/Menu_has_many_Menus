class Recipe < ApplicationRecord
  SEARCH_CRITERIA = {
    MEAL_TYPES: Meal::MEAL_TYPES,
    COURSE_TYPES: Course::COURSE_TYPES,
    DIETARY_FILTERS: ["vegan", "vegetarian", "paleo"]
  }

  def recipe_image( attr = {})
    sz = attr[:size].upcase
    images[sz]["url"]
  end
end
