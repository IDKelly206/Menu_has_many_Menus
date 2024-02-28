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
    household.groceries.select { |g| g if g.list_add == true }
  end

  def self.grocery_list(groceries)
    ingredient_names = groceries.map { | g_item | g_item.name.singularize.downcase }.uniq
    grocery_list_names = []
    ingredient_names.each_with_index do |name, index|
      grocery_list_names[index] = {}
      grocery_list_names[index][:n] = name.singularize.downcase
      grocery_list_names[index][:g_ids] = []
    end

    groceries.each do |g|
      name = g.name.singularize.downcase
      g_item = grocery_list_names.detect { |i| i[:n] == name }
      g_item[:g_ids].push(g.id.to_s)
    end

    grocery_list_names
  end


end
