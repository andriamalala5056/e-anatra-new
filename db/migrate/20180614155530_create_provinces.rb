class CreateProvinces < ActiveRecord::Migration[5.2]
  def change
    create_table :provinces do |t|
      t.string :nom

      t.timestamps
    end
  end
end
