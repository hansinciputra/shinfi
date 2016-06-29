class Addconnectortoworkshoptable < ActiveRecord::Migration
  def change
  	add_column :workshops, :connector, :string
  end
end
