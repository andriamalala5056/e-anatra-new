class AddColumnToAssiciateFiliereEtabs < ActiveRecord::Migration[5.2]
  def change
    add_column :associate_filiere_etabs, :niveau, :string
    add_column :associate_filiere_etabs, :place, :integer
  end
end
