class AddColumnVagueEtabs < ActiveRecord::Migration[5.2]
  def change
    add_reference :vagues, :etablissement, foreign_key: true
  end
end
