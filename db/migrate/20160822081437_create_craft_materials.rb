class CreateCraftMaterials < ActiveRecord::Migration
  def change
    create_table :craft_materials do |t|
      t.integer :craft_id
      t.integer :material_id
      t.string :selected
      t.decimal :price

      t.timestamps
    end
  end
end
