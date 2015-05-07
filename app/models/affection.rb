class Affection < ActiveRecord::Base

  # Associations
  belongs_to :affectable, polymorphic: true
  belongs_to :server
  
end
