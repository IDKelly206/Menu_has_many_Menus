class Health < ApplicationRecord
  has_many :dietary_restrictions

  validates :parameter, presence: true, uniqueness: true
  scope :by_name, -> { order(:parameter) }
end
