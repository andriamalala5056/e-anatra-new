class AddCulumnNiveauPlaceToAssociates < ActiveRecord::Migration[5.2]
  def change
    add_reference :associate_filiere_etabs, :level, foreign_key: true
    add_column :associate_filiere_etabs, :place, :integer
  end
end
