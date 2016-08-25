class CraftMaterial < ActiveRecord::Base
	belongs_to :craft, :inverse_of => :craft_materials
	belongs_to :material , :inverse_of => :craft_materials

	accepts_nested_attributes_for :material, allow_destroy: true
end
