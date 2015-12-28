class Adddptoprodimg < ActiveRecord::Migration
  def change
  	add_column :product_images,:displaypic, :integer
  end
end
