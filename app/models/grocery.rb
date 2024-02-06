class Grocery < ApplicationRecord
  belongs_to :household
  belongs_to :course

  validates :name, presence: true
  validates :quantity, presence: true
  validates :measurement, presence: true
  validates :erecipe_id, presence: true
  validates :course_id, presence: true

  #  Add ordered sequence of :foodCat then :name

  def self.groceries(household)
    select { |g_item| g_item.household_id = household && g_item.list_add == true }
  end

  def self.grocery_list(groceries)
    ingredient_names = groceries.map { | g_item | g_item.name.singularize.downcase }.uniq
    grocery_list_names = []
    ingredient_names.each_with_index do |name, index|
      grocery_list_names[index] = {}
      grocery_list_names[index][:n] = name.singularize.downcase
    end
    grocery_list_names
  end


end
