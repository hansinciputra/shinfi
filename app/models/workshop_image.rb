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
end
