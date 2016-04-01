class CreatePriceDets < ActiveRecord::Migration
  def change
    create_table :price_dets do |t|
      t.integer :craft_id
      t.string :subject
      t.decimal :price

      t.timestamps
    end
  end
end
