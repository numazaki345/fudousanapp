class CreateBuildings < ActiveRecord::Migration[7.0]
  def change
    create_table :buildings do |t|
      t.string  :structure_type, null: false
      t.integer :zipcode,        null: true
      t.string  :prefectures,    null: false
      t.string  :city,           null: false
      t.string  :town_name,      null: false
      t.string  :name,           null: false
      t.string  :transportation, null: false
      t.integer :completion,     null: true
      t.integer :floor_height,   null: true
      t.string  :building_type,  null: false
      t.string  :balcony_type,   null: true

      t.timestamps
    end
  end
end
