class WorkshopImage < ActiveRecord::Base
	mount_uploader :craft_image, WorkshopImageUploader
	belongs_to :workshop
	after_create :set_first_upload_dp

	def set_first_upload_dp
		image = WorkshopImage.where(:connector => self.connector).where(:display_pic => 'DP')
		if image.count < 1
			self.display_pic = 'DP'
			save
		end
	end
	def self.setDisplayPic(id,connector)
		#get all picture of the specified product id
			@workshopimage = WorkshopImage.where(:connector => connector)
		#set all picture display pic to 0, unset all previously choosen display pic
		@workshopimage.each do |t|
			t.update_attribute(:display_pic,nil)
		end
		#get the selected product image wanted to be the display pic
		@set_dp_images = WorkshopImage.find(id)
		#in model need to use sql command to CRUD attributes
		@set_dp_images.update_attribute(:display_pic,'DP')
			
	end
end
