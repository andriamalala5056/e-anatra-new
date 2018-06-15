class CreateVagues < ActiveRecord::Migration[5.2]
  def change
    create_table :vagues do |t|
      t.date :rentree
      t.boolean :status

      t.timestamps
    end
  end
end
