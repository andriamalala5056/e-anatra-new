class AddCulumnProvinceToEtablissements < ActiveRecord::Migration[5.2]
  def change
    add_reference :etablissements, :province, foreign_key: true
  end
end
