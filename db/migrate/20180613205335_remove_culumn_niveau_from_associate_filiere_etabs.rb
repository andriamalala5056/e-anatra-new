class RemoveCulumnNiveauFromAssociateFiliereEtabs < ActiveRecord::Migration[5.2]
  def change
    remove_column :associate_filiere_etabs, :niveau, :string
    remove_column :associate_filiere_etabs, :place, :integer
  end
end
