class Health < ApplicationRecord
  before_validation :create_health_options

  has_many :dietary_restrictions

  validates :parameter, presence: true, uniqueness: true

  scope :by_name, -> { order(:parameter) }

  private

  HEALTH_TYPES = [
    "vegetarian",
    "egg-free",
    "kosher",
    "dairy-free",
    "vegan",
    "test"
  ]

  def create_health_options
    HEALTH_TYPES.each { |type| Health.create(parameter: type) }
  end

end
