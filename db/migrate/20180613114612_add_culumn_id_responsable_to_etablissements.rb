class AddCulumnIdResponsableToEtablissements < ActiveRecord::Migration[5.2]
  def change
    add_column :etablissements, :responsable_id, :integer
  end
end
