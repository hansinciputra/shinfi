class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name
      t.string :purpose
      t.string :picture
      t.integer :quantity

      t.timestamps
    end
  end
end
