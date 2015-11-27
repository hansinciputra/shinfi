class TypeInventory < ActiveRecord::Base
	validate :name, :presence => true
end
