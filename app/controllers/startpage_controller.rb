class StartpageController < ApplicationController
	def index
    @workshops = Workshop.for_startpage
	end
end