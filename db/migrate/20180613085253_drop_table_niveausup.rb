class DropTableNiveausup < ActiveRecord::Migration[5.2]
  def change
    drop_table :associate_niveausup_filieres
    drop_table :niveausups
  end
end
