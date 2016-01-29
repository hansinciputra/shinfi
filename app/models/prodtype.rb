class Prodtype < ActiveRecord::Base
	validates :name , :presence => true
end
