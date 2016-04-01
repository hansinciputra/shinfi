class CreateCrafts < ActiveRecord::Migration
  def change
    create_table :crafts do |t|
      t.string :name
      t.integer :PriceDet_id
      t.integer :user_id
      t.string :category
      t.string :price_determinant
      t.text :prod_desc
      t.integer :brand_id
      t.decimal :quantity
      t.string :availability

      t.timestamps
    end
  end
end
