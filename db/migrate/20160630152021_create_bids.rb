class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :product_id, index: true, foreign_key: true
      t.integer :user_id, index: true, foreign_key: true
      t.decimal :bidded, precision:10, scale:2, default:0.00
      t.timestamps null: false
    end
  end
end
