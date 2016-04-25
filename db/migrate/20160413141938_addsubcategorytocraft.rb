class Addsubcategorytocraft < ActiveRecord::Migration
  def change
  	add_column :crafts , :subcategory, :string
  end
end
