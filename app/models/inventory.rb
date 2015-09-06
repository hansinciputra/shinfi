class Inventory < ActiveRecord::Base
  #check ruby guides for full validates helper
  has_attached_file :image, :styles => { :thumb => "250x250>"} ,
       :default_url => "missing.png",
       :default_style => "150x150#",
       :keep_old_file => false
  validates_attachment_content_type :image, 
      :content_type => ["image/jpg" ,"image/jpeg", "image/png"] 
  validates_attachment_size :image, :less_than => 5.megabytes
  
  validates :pName, :pQuantity, :pMeter, :pWeight, :pSellPrice, :pCategory, :presence => true
  validates :pName, :uniqueness => {:messages => "Nama Barang Sudah Ada"}
  validates :pQuantity,:pWeight,:pSellPrice, :numericality => true
  
end