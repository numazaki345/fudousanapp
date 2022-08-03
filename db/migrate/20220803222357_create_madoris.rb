class CreateMadoris < ActiveRecord::Migration[7.0]
  def change
    create_table :madoris do |t|
      t.string :rent,    null: false
      t.string :square,  null: false

      t.timestamps
    end
  end
end
