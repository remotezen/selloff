class CreateSellers < ActiveRecord::Migration
  def change
    create_table :sellers do |t|
      t.integer :user_id
      t.integer :product_id

      t.timestamps null: false
    end
    add_index :sellers, :user_id
    add_index :sellers, :product_id
  end
end
