class AddUserIdToBuildings < ActiveRecord::Migration[7.0]
  def up
    execute 'DELETE FROM buildings;'
    add_reference :buildings, :user, null: false, index: true
  end

  def down
    remove_reference :buildings, :user, index: true
  end
end
