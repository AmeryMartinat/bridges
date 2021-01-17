class AddingTravelTimeToTrip < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :travel_time, :decimal, null: true
  end
end
