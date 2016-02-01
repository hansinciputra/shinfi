class AddTypeToPosters < ActiveRecord::Migration
  def change
  	add_column :posters, :type, :string
  end
end
