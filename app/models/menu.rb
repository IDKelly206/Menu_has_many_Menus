class Menu < ApplicationRecord
  after_create :create_menu_meals

  belongs_to :household

  has_many :meals, dependent: :destroy

  validates :date, presence: true

  scope :ordered, -> { order(date: :asc) }


  def day_of_week
    "#{self.date.strftime('%a')}: #{self.date.day.ordinalize}  "
  end

  private

  def self.calendar
    (Time.now.to_date...(Time.now.to_date + 7))
  end

  def self.create_menus(household)
    calendar = Menu.calendar
    menu_count = Menu.where('household_id = ?', household).where('date IN (:cal)', { cal: calendar }).count
    if menu_count >= calendar.count
      @menus = Menu.where('household_id = ?', household).where('date IN (:cal)', { cal: calendar }).ordered
    else
      cal_menu = Menu.where('household_id = ?', household).where('date IN (:cal)', { cal: calendar }).ordered
      menu_dates = cal_menu.map { |d| d.date }
      menu_dates_missing = calendar.select { |d| d if menu_dates.exclude?(d) }
      menu_dates_missing.each { |d| Menu.create!(date: d, household_id: household.id) }
      @menus = Menu.where('household_id = ?', household).where('date IN (:cal)', { cal: calendar }).ordered
    end
  end

  def create_menu_meals
    menu = self
    household = Household.find(menu.household_id)
    users = household.users
    meal_types = Meal::MEAL_TYPES
    users.each do |user|
      meal_types.each do |meal_type|
        Meal.create!(menu: menu, user: user, meal_type: meal_type)
      end
    end
  end
end
