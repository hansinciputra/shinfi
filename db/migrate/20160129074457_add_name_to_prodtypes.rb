class AddNameToProdtypes < ActiveRecord::Migration
  def change
  	add_column :prodtypes, :name ,:string
  end
end
