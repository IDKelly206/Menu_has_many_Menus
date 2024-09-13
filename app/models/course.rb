class Course < ApplicationRecord
  belongs_to :meal

  has_many :groceries, dependent: :destroy

  validates :course_type, presence: true
  validates :meal_id, presence: true

  COURSE_TYPES = [
    "starter",
    "soup",
    "salad",
    "main course",
    "desserts",
    "drinks"
  ]

  meal_types = [
    'breakfast',
    'brunch',
    'lunch/dinner',
    'snack'
  ]

  dish_types = [
    'alcohol cocktail',
    'biscuits and cookies',
    'bread',
    'cereals',
    'condiments and sauces',
    'desserts',
    'drinks',
    'egg',
    'ice cream and custard',
    'main course',
    'pancake',
    'pasta',
    'pastry',
    'pies and tarts',
    'pizza',
    'preps',
    'preserve',
    'salad',
    'sandwiches',
    'seafood',
    'side dish',
    'special occasions',
    'starter',
    'sweets'
  ]
end
