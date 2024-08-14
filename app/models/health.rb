class Health < ApplicationRecord
  has_many :dietary_restrictions

  validates :parameter, presence: true, uniqueness: true

  scope :by_name, -> { order(:parameter) }

  HEALTH_TYPES = [
    "vegetarian",
    "egg-free",
    "kosher",
    "dairy-free",
    "vegan",
    "test"
  ]
end
