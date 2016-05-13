class PriceDet < ActiveRecord::Base
	belongs_to :craft
	def combine_subject_price
		"#{subject}[Rp #{price}]"
	end

end
