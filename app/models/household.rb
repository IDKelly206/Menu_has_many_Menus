class Household < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :menus, dependent: :destroy
end
