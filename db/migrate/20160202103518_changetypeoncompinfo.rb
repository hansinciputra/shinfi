class Changetypeoncompinfo < ActiveRecord::Migration
  def change
  	remove_column :compinfos, :type
  	add_column :compinfos, :infotype, :string
  end
end
