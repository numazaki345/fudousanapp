class CreateConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :conditions do |t|
      t.string      :area,      null: false
      t.string      :rent_high
      t.string      :rent_low
      t.string      :rent_option
      t.string      :minute
      t.string      :madori
      t.string      :building
      t.string      :completion
      t.string      :row
      t.references  :client,    null: false, foreign_key: true

      t.timestamps
    end
  end
end
