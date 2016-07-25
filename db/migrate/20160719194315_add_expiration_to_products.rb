class AddExpirationToProducts < ActiveRecord::Migration
  def change
    add_column :products, :expiration, :timestamp
  end
end
