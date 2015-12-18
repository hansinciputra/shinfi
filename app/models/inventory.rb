class Inventory < ActiveRecord::Base
  #check ruby guides for full validates helper
  has_many :inventory_orders, :inverse_of => :inventory
  has_many :orders, through: :inventory_orders
  has_many :product_images, dependent: :destroy #if inventory is removed, the picture also removed

  validates :name, :quantity, :meter, :weight, :sellprice, :presence => true
  validates :name, :uniqueness => {:messages => "Nama Barang Sudah Ada"}
  validates :quantity,:weight,:sellprice, :numericality => true
   
  accepts_nested_attributes_for :inventory_orders, :reject_if => lambda { |a| a[:quantity].blank?}
  accepts_nested_attributes_for :product_images, :allow_destroy => true #allow destroy of child in parent form
  def reduce_inventory(qty)
    self.quantity = quantity - qty
    save
  end
  def add_inventory(qty)
    self.quantity = self.quantity + qty
    save
  end
end