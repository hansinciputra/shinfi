class AddMoreToCustomers < ActiveRecord::Migration
  def change
  	add_column :customers, :provinsi ,:string
  	add_column :customers, :kota ,:string
  	add_column :customers, :kodepos ,:string
  	add_column :customers, :email ,:string
  	add_column :customers, :user_id ,:integer
  	add_column :customers, :signas ,:string
  	add_column :customers, :phone2 ,:string
  	add_column :customers, :address2 ,:string
  end
end
