class StartpageController < ApplicationController
	def index
    @workshops = Workshop.for_startpage.decorate
	end
end