class Compinfo < ActiveRecord::Base
	belongs_to :user
	validates_uniqueness_of :infotype
end
