class Menu < ApplicationRecord
  belongs_to :household

  has_many :meals

  validates :date, presence: true
end
