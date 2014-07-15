class StartpageController < ApplicationController
	def index
    @workshops = Workshop.for_startpage.decorate
	end

  def terms
  end
end