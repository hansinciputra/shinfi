class Addimagetoposter < ActiveRecord::Migration
  def change
  	add_column :posters, :mainposter, :string
  	add_column :posters, :subposter, :string
  	add_column :posters, :banner, :string
  	add_column :posters, :squareposter, :string
  end
end
