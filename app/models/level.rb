class Level < ApplicationRecord
    has_many :associate_filiere_etabs

    has_many :inscriptions
    has_many :user, through: :inscriptions
end
