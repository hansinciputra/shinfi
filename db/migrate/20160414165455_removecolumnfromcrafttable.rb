class Removecolumnfromcrafttable < ActiveRecord::Migration
  def change
  	remove_column :crafts, :PriceDet_id
  	rename_column :crafts, :availability , :active
  	add_column :price_dets, :quantity, :decimal
  	add_column :price_dets, :availablity, :string
  end
end
