class CreateEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :emails do |t|
      t.string  :email,        null: false
      t.text    :building_url, null: false

      t.timestamps
    end
  end
end
