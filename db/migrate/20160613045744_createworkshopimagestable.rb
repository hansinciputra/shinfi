class Createworkshopimagestable < ActiveRecord::Migration
  def change
  	create_table :workshop_images do |t|
      t.string :craft_image
      t.string :workshops_id
      t.string :connector
      t.timestamps
    end
  end
end
