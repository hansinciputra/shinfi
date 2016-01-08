class Removecolumninventory < ActiveRecord::Migration
  def change
  	remove_column :inventories, :pic
  	remove_column :inventories, :image_file_name
  	remove_column :inventories, :image_content_type
  	remove_column :inventories, :image_file_size
  	remove_column :inventories, :image_updated_at
  	remove_column :inventories, :prod_img
  end
end
