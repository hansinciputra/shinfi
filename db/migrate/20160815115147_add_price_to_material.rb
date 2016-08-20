class AddPriceToMaterial < ActiveRecord::Migration
  def change
  	add_column :materials, :price, :decimal
  end
end
