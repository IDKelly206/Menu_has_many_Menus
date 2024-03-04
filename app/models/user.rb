class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  before_validation :assign_household
  after_create :create_user_meals

  validates :name_first, :name_last, :household_id, presence: true
  validates :email, uniqueness: true

  belongs_to :household

  has_many :meals, dependent: :destroy
  has_many :dietary_restrictions, dependent: :destroy
  has_many :healths, through: :dietary_restrictions
  accepts_nested_attributes_for :dietary_restrictions, allow_destroy: true


  def assign_household
    if self.household_id.nil?
      Household.create
      self.household_id = Household.last.id
    end
  end

  private

  def create_dietary_restrictions(health_restrictions)
    unless health_restrictions.empty?
      health_restrictions.each { |h| DietaryRestriction.create!(user: self, health: h)}
    end

    # create if
    # destroy if
    # there is no updating
  end


  def create_user_meals
    user_id = self.id
    household = User.last.household_id
    calendar = (Time.now.to_date...(Time.now.to_date+10))
    menu_ids = Menu.where('household_id = ?', household).where('date IN (:cal)', { cal: calendar }).ids
    meal_types = %w(Breakfast Lunch Dinner)

    menu_ids.each do |menu_id|
      meal_types.each do |meal_type|
        Meal.create!(user_id: user_id, menu_id: menu_id, meal_type: meal_type)
      end
    end
  end

end
