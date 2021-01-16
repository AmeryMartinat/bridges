class CreateBridges < ActiveRecord::Migration[6.1]
  def change
    create_table :bridges do |t|
      t.decimal :length
      t.integer :sort_order

      t.timestamps
    end
  end
end
