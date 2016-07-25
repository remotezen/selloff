class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :quantity, default: 1
      t.float :price, default: 0.0, precision:10, scale:2
      t.references :user, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.references :bid, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
