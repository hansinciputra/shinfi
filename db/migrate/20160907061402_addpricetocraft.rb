class Addpricetocraft < ActiveRecord::Migration
  def change
  	add_column :crafts, :price, :decimal
  end
end
