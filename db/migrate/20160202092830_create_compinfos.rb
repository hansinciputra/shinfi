class CreateCompinfos < ActiveRecord::Migration
  def change
    create_table :compinfos do |t|
      t.string :title
      t.text :content
      t.string :type
      t.integer :creator

      t.timestamps
    end
  end
end
