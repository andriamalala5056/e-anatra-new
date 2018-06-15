class AddColumnUserEtabToInscriptions < ActiveRecord::Migration[5.2]
  def change
    add_reference :inscriptions, :user, foreign_key: true
    add_reference :inscriptions, :etablissement, foreign_key: true
  end
end
