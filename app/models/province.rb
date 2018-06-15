class Province < ApplicationRecord
    has_many :etablissements
    validates :nom, presence: true
    validates :nom, uniqueness: true

    has_many :inscriptions
    has_many :user, through: :inscriptions
end
