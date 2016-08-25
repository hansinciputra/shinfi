class Material < ActiveRecord::Base
	mount_uploader :picture, MaterialUploader
	belongs_to :user
	#many to many relations with crafts
	has_many :craft_materials , :inverse_of => :materials
	has_many :crafts , :through => :craft_materials

	#to get data from session array
	def self.material_on_category(variable)
		#first we create empty array to store the value
		list_material = []
		#for each variable which is an array from view we itterate
		variable.each do |x|
			#we find every materials that has purpose of "x" this will result in array since use WHERE on SQL syntax
			material_array = Material.where :purpose => x
			#we need the result to be not in array, so we breakdown the array to individual result
			material_array.each do |material_per_unit|
				#we store each individual result to the empty array we created before
				list_material << material_per_unit
			end
		end	
		#we return the array of results to controller
		return list_material
	end


end
