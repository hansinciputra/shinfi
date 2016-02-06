class ReportController < ApplicationController
	before_filter :authorize
	before_filter :authorize_admin
	def index
		
	end
end