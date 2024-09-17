class Course < ApplicationRecord
  belongs_to :meal

  has_many :groceries, dependent: :destroy

  validates :course_type, presence: true
  validates :meal_id, presence: true

  COURSE_TYPES = ['main', 'starter', 'side']

  DISH_TYPES = {
    main: ['main course', 'egg', 'salad', 'soup'],
    starter: ['starter', 'pancake', 'salad', 'soup'],
    side: ['alcohol cocktail',
           'biscuits and cookies',
           'bread',
           'cereals',
           'condiments and sauces',
           'desserts',
           'preserve',
           'salad',
           'sandwich',
           'special occasions']
  }

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
    'soup',
    'special occasions',
    'starter',
    'sweets'
  ]
end
