class AddColumnLevelToInscriptions < ActiveRecord::Migration[5.2]
  def change
    add_reference :inscriptions, :level, foreign_key: true
  end
end
