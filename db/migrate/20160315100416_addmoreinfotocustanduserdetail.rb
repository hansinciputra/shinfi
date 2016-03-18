class Addmoreinfotocustanduserdetail < ActiveRecord::Migration
  def change
  	add_column :users, :kecamatan, :string
  	add_column :users, :kelurahan, :string
  	add_column :users, :fb_contact, :string
  	add_column :users, :insta_contact, :string
  	add_column :customers, :kecamatan, :string
  	add_column :customers, :kelurahan, :string
  	add_column :customers, :fb_contact, :string
  	add_column :customers, :insta_contact, :string
  end
end
