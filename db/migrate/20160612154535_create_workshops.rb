class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :craft_image
      t.string :title
      t.text :description
      t.uuid :user_id
      t.string :publish_status

      t.timestamps
    end
  end
end
