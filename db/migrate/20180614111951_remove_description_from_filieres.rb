class RemoveDescriptionFromFilieres < ActiveRecord::Migration[5.2]
  def change
    remove_column :filieres, :description, :text
  end
end
