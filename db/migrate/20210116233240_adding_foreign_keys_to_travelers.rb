class AddingForeignKeysToTravelers < ActiveRecord::Migration[6.1]
  def change
    add_column :travelers, :trip_id, :integer, null: true
    add_column :travelers, :bridge_id, :integer, null: true
    add_column :bridges, :trip_id, :integer, null: true
  end
end
