class Workshop < ActiveRecord::Base
	belongs_to :user
	has_many :workshop_images, dependent: :destroy 
	after_create :update_workshop_image_id
	after_update :update_workshop_image_id

	accepts_nested_attributes_for :workshop_images, :allow_destroy => true #allow destroy of child in parent form
		def update_workshop_image_id
		image = WorkshopImage.where(:connector => self.connector)
		image.each do |x|
			x.update_attributes :workshop_id => self.id
		end
	end
	scope :get_user_workshop, ->(user_id){where('user_id = ?', user_id)}
	scope :published, ->{where ("publish_status = 'published'")}
	scope :not_published, ->{where ("publish_status = 'no_publish'")}
	
end
