class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.string :name
      t.integer :inventory_id

      t.timestamps
    end
  end
end
