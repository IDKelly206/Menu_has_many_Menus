class Health < ApplicationRecord
  has_many :dietary_restrictions

  scope :by_name, -> { order(:parameter) }
end
