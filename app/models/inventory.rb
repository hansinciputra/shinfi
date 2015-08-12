class Inventory < ActiveRecord::Base
  #check ruby guides for full validates helper
  validates :pName, :pQuantity, :pMeter, :pWeight, :pSellPrice, :pCategory, :presence => true
  validates :pName, :uniqueness => {:messages => "Nama Barang Sudah Ada"}
  validates :pQuantity,:pWeight,:pSellPrice, :numericality => true
  
end