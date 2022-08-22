class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string  :name,       null: false
      t.integer :birth,      null: false
      t.string  :gender,     null: false

      # 条件モデル
      t.string  :rent_high
      t.string  :rent_low
      t.string  :rent_option
      t.string  :minute
      t.string  :madori
      t.string  :building
      t.string  :completion
      t.string  :conditions

      t.timestamps
    end
  end
end
