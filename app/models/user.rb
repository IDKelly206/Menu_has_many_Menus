class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  validates :name_first, :name_last, :household_id, presence: true
  validates :email, uniqueness: true

  belongs_to :household

  has_many :meals

  before_validation :assign_household

  def assign_household
    if self.household_id.nil?
      Household.create
      self.household_id = Household.last.id
    end
  end



end
