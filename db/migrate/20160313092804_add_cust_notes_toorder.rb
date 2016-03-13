class AddCustNotesToorder < ActiveRecord::Migration
  def change
  	add_column :orders, :cust_notes, :text
  end
end
