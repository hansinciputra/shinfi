class Customer < ActiveRecord::Base
	has_many :orders, dependent: :destroy #dependent: :destroy - if customer is deleted , all of the customers order also deleted
	validates :name ,:phone ,:address ,:presence => true

	#validates :phone, :uniqueness => {:messages => "Nomor Telepon sudah terdaftar"}
end
