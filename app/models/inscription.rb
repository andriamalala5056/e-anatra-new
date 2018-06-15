class Inscription < ApplicationRecord
    belongs_to :user
    belongs_to :etablissement
    belongs_to :vague
    belongs_to :filiere
    belongs_to :province
    belongs_to :level
end
