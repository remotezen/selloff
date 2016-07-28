class AddIncrementToProducts < ActiveRecord::Migration
  def change
    add_column :products, :minimum_increment, :float, precision:10, scale: 2, default: 1.00
  end
end
