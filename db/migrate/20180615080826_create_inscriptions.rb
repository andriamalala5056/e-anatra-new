class CreateInscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :inscriptions do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :etablissement, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
