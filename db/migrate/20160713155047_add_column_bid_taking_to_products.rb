class AddColumnBidTakingToProducts < ActiveRecord::Migration
  def change
    add_column :products, :bid_taking, :integer, default: 1
  end
end
