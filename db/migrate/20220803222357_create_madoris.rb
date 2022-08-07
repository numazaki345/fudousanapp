class CreateMadoris < ActiveRecord::Migration[7.0]
  def change
    create_table :madoris do |t|
      t.string :rent,    null: false
      t.string :square,  null: false
      t.string :room_number, null: false
      t.references :building, null: false, foreign_key: true

      t.timestamps
    end
    add_index :madoris, [:building_id, :created_at]
  end
end
