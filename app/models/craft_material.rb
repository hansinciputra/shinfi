class CraftMaterial < ActiveRecord::Base
	belongs_to :craft, :inverse_of => :craft_materials
	belongs_to :material , :inverse_of => :craft_materials

	accepts_nested_attributes_for :material, allow_destroy: true


	def delete_record(craftmaterial_id)
		CraftMaterial.find(craftmaterial_id).destroy
		save
	end
	def self.add_record(material_id,craft_id)
		new_record = CraftMaterial.new(:craft_id => craft_id, :material_id => material_id, :selected=> 'YES')
		new_record.save
	end
end
