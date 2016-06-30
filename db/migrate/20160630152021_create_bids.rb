class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :product_id 
      t.integer :user_id
      t.decimal :bidded, precision:10, scale:2, default:0.00
      t.timestamps null: false
    end
    add_index :bids, :product_id
    add_index :bids, :user_id
  end
end
