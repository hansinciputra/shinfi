class Adduuidrelationtoorder < ActiveRecord::Migration
  def change
  	add_column :orders, :user_id, :uuid
  end
end
