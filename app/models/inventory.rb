class Inventory < ActiveRecord::Base
  #check ruby guides for full validates helper
  has_many :inventory_orders, :inverse_of => :inventory
  has_many :orders, through: :inventory_orders
  
  has_attached_file :image, :styles => { :thumb => "250x250>"} ,
       :default_url => "missing.png",
       :default_style => "150x150#",
       :keep_old_file => false
  validates_attachment_content_type :image, 
      :content_type => ["image/jpg" ,"image/jpeg", "image/png"] 
  validates_attachment_size :image, :less_than => 5.megabytes
  
  validates :name, :quantity, :meter, :weight, :sellprice, :category, :presence => true
  validates :name, :uniqueness => {:messages => "Nama Barang Sudah Ada"}
  validates :quantity,:weight,:sellprice, :numericality => true
   
  accepts_nested_attributes_for :inventory_orders, :reject_if => lambda { |a| a[:quantity].blank?}

end