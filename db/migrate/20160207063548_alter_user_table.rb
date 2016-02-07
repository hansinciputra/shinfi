class AlterUserTable < ActiveRecord::Migration
  def change
  	add_column :users, :address, :string
  	add_column :users, :address2, :string
  	add_column :users, :phone, :string
  	add_column :users, :phone2, :string
  	add_column :users, :provinsi, :string
  	add_column :users, :kota, :string
  	add_column :users, :kodepos, :string
  	add_column :users, :dateofbirth, :date
  end
end
