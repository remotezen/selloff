class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :image_url
      t.decimal :minimum_bid, precision:10, scale:2
      t.decimal :maximum_bid, precision:10, scale:2
      t.text :description
      t.string :name
      t.string :category

      t.timestamps null: false
    end
  end
end
