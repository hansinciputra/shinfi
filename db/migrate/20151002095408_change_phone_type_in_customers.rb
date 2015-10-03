class ChangePhoneTypeInCustomers < ActiveRecord::Migration
  def self.up
  	change_column :customers, :phone, :string
  end
  def self.down
  	change_column :customers, :phone, :integer
  end

end
