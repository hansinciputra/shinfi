class Material < ActiveRecord::Base
	mount_uploader :picture, MaterialUploader
	belongs_to :user
end
