class User < ApplicationRecord
  belongs_to :household
  accepts_nested_attributes_for :household


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def with_household
    self.household.build
    self
  end

end
