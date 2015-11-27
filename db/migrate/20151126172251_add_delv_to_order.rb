class AddDelvToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :delvmethod, :string
  end
end
