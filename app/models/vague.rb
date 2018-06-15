class Vague < ApplicationRecord
    
  has_many :inscriptions
  has_many :user, through: :inscriptions

  belongs_to :etablissement
end
