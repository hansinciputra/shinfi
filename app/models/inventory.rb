class Inventory < ActiveRecord::Base
  #check ruby guides for full validates helper
  has_many :inventory_orders, :inverse_of => :inventory
  has_many :orders, through: :inventory_orders
  has_many :product_images, dependent: :destroy #if inventory is removed, the picture also removed
  belongs_to :brand

  validates :name, :quantity, :sellprice, :presence => true
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

  def self.import(file)
    #call open_spreadsheet action
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    #(2..spreadsheet.last_row) will loop each row from row 2 to last row
    (2..spreadsheet.last_row).each do |i|
      #we combine header and each row of spreadsheet as key=>value pair inside Hash
      row = Hash[[header,spreadsheet.row(i)].transpose]

      inventory = Inventory.find_by_name(row["name"]) || Inventory.new
      parameters = ActionController::Parameters.new(row.to_hash)
      inventory.update(parameters.permit(:name,:material,:fabrictype,:link, :quantity, :meter, :weight, :sellprice, :prodtype,:category,:satuan,:ukuran,:berat,:warna))  
      inventory.save!
    end
  end
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::Csv.new(file.path,packed: nil, file_warning: :ignore)
      when ".xls" then Roo::Excel.new(file.path,packed: nil,file_warning: :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path,packed: nil,file_warning: :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end      
  end
  def self.list_all_po_items
    ProductImage.joins(:inventory).select('product_images.prod_img,product_images.id,product_images.inventory_id,inventories.name,inventories.category,inventories.fabrictype,inventories.quantity,inventories.satuan,inventories.sellprice').where(:displaypic => 1).where("inventories.category = 'KRCN Imported'")
  end
  scope :get_fabric,->{joins(:product_images).select('product_images.prod_img,product_images.id,product_images.inventory_id,inventories.name,inventories.category,inventories.brand_id,inventories.fabrictype,inventories.quantity,inventories.satuan,inventories.sellprice').where('product_images.displaypic' => 1).where("inventories.prodtype = 'Fabric'").where("inventories.quantity > ?", 0)}
  scope :get_supply,->{joins(:product_images).select('product_images.prod_img,product_images.id,product_images.inventory_id,inventories.name,inventories.category,inventories.brand_id,inventories.fabrictype,inventories.quantity,inventories.satuan,inventories.sellprice').where('product_images.displaypic' => 1).where("inventories.prodtype = 'Accessories'").where("inventories.quantity > ?", 0)}
  scope :brand,->(brand){where('brand_id=?',brand)}
  scope :fabrictype,->(fabrictype){where('fabrictype=?',fabrictype)}
  scope :category, ->(category){where('category=?',category)}
  scope :minprice, ->(min){where('sellprice >= ?',min)}
  scope :maxprice, ->(max){where('sellprice <= ?',max)}
  scope :warna,->(warna){where('warna =?',warna)}
end