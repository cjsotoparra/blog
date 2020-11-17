class ApplicationController < ActionController::Base
	def hello
		render html: 'hell world!'
	end
end
