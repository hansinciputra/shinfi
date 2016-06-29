class Adddisplaypictoworkshopimage < ActiveRecord::Migration
  def change
  	add_column :workshop_images, :display_pic, :string
  end
end
