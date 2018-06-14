class AssociateFiliereEtab < ApplicationRecord
    belongs_to :filiere
    belongs_to :etablissement
    belongs_to :level
end
