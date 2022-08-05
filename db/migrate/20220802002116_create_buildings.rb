class CreateBuildings < ActiveRecord::Migration[7.0]
  def change
    create_table :buildings do |t|
      t.string :name,        null: false
      t.string :address,     null: false

      t.timestamps
    end
  end
end