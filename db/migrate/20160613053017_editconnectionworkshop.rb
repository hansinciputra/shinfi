class Editconnectionworkshop < ActiveRecord::Migration
  def change
  	remove_column :workshop_images, :workshops_id
  	add_column :workshop_images, :workshop_id, :integer
  end
end
