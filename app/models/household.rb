class Household < ApplicationRecord
  after_create :generate_menus

  has_many :users, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :groceries, dependent: :destroy

  def generate_menus
    household = self
    Menu.create_menus(household)
  end
end
