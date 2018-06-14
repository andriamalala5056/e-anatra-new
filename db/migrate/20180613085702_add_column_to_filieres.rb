class AddColumnToFilieres < ActiveRecord::Migration[5.2]
  def change
    add_column :filieres, :niveau, :string
    add_column :filieres, :place, :integer
  end
end
