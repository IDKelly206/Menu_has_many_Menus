class Health < ApplicationRecord
  # after_create :create_health_options
  # after_create :remove_health_options

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
    "test 150"
  ]

  def create_health_options
    HEALTH_TYPES.each do |t|
      Health.create(parameter: t) if Health.where(parameter: t).empty?
    end
  end

  def remove_health_options
    Health.all.each do |h|
      Health.where(parameter: h.parameter).delete_all unless HEALTH_TYPES.include?(h.parameter)
    end
  end

end
