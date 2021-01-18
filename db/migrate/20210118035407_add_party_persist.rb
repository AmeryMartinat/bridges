class AddPartyPersist < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :persist_party, :boolean, default: false
  end
end
