class DietaryRestriction < ApplicationRecord
  belongs_to :health
  belongs_to :user

  
end
