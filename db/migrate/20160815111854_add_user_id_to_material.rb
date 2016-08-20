class AddUserIdToMaterial < ActiveRecord::Migration
  def change
  	add_column :materials, :user_id, :uuid
  end
end
