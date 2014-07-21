class StartpageController < ApplicationController
	def index
    @workshops = Workshop.for_startpage.decorate

    @passed_workshops = @workshops.select { |workshop| workshop.passed? }
    @current_workshops = @workshops.select { |workshop| !workshop.passed? }
	end

  def terms
  end
end