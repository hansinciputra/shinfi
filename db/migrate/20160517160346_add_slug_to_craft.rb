class AddSlugToCraft < ActiveRecord::Migration
  def change
  	add_column :crafts, :slug, :string
  	add_index :crafts, :slug
  end
end
