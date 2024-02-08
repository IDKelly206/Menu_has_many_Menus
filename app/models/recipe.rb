class Recipe < ApplicationRecord
  SEARCH_CRITERIA = {
    MEAL_TYPES: Meal::MEAL_TYPES,
    COURSE_TYPES: Course::COURSE_TYPES,
    DIETARY_FILTERS: ["vegan", "vegetarian", "paleo"]
  }

  # size options = THUMBNAIL, SMALL & REGULAR
  def recipe_image( attr = {})
    sz = attr[:size].upcase
    images[sz]["url"]
  end
end
