class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.integer :seller_id
      t.integer :bid_id

      t.timestamps null: false
    end
    add_index :auctions, :bid_id
    add_index :auctions, :seller_id
  end
end
