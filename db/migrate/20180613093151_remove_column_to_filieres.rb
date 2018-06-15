class RemoveColumnToFilieres < ActiveRecord::Migration[5.2]
  def change
    remove_column :filieres, :niveau, :string
    remove_column :filieres, :place, :integer
  end
end
