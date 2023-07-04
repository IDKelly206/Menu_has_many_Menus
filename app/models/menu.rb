class Menu < ApplicationRecord
  belongs_to :household

  has_many :meals, dependent: :destroy

  validates :date, presence: true
end
