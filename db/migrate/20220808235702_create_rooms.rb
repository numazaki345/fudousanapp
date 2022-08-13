class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string     :rent,    null: false
      t.string     :square,  null: false
      t.string     :room_number, null: false
      t.string     :madori, null: false
      t.string     :floor, null: false
      t.references :building, null: false, foreign_key: true

      t.timestamps
    end
  end
end
