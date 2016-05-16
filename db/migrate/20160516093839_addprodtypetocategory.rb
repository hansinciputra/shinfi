class Addprodtypetocategory < ActiveRecord::Migration
  def change
  	add_column :categories, :productype, :string
  end
end
