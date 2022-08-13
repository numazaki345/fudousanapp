class CreateBuildings < ActiveRecord::Migration[7.0]
  def change
    create_table :buildings do |t|
      t.string :name,           null: false
      t.string :zipcode,        null: false
      t.string :prefectures,    null: false
      t.string :transportation, null: false
      t.string :completion,     null: false
      t.string :floor_height,   null: false
      t.string :building_type,  null: false
      t.string :balcony_type,   null: false
      t.string :structure_type, null: false
      t.string :city,           null: false
      t.string :town_name,      null: false

      t.timestamps
    end
  end
end
