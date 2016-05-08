class Craftuseridtouuid < ActiveRecord::Migration
  def change
  	remove_column :crafts, :user_id
  	add_column :crafts, :user_id, :uuid
  end
end
