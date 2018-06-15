class Filiere < ApplicationRecord
    has_many :associate_filiere_etabs
    has_many :etablissement, through: :associate_filiere_etabs

    has_many :inscriptions
    has_many :user, through: :inscriptions

    validates :nom, presence: true
    validates :nom, uniqueness: true
end
