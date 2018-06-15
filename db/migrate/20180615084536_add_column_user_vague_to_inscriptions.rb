class AddColumnUserVagueToInscriptions < ActiveRecord::Migration[5.2]
  def change
    add_reference :inscriptions, :vague, foreign_key: true
  end
end
