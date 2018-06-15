class RemoveColomnFromAssociateNiveausupFiliere < ActiveRecord::Migration[5.2]
  def change
    remove_column :associate_niveausup_filieres, :niveausup_id, :integer
    remove_column :associate_niveausup_filieres, :filiere_id, :integer
  end
end
