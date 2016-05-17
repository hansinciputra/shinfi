class AddSlugToInventory < ActiveRecord::Migration
  def change
  	add_column :inventories, :slug, :string
  	add_index :inventories, :slug
  end
end
