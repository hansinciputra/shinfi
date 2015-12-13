class AddImgUploaderToProdImage < ActiveRecord::Migration
  def change
  	add_column :product_images, :prod_img, :string
  end
end
