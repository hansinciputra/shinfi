class CreatePosters < ActiveRecord::Migration
  def change
    create_table :posters do |t|
      t.string :name
      t.integer :display

      t.timestamps
    end
  end
end
