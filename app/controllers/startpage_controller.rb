class StartpageController < ApplicationController
	def index
    @workshops = Workshop.for_startpage.decorate

    @passed_workshops = @workshops.select { |workshop| workshop.passed? }
    @current_workshops = @workshops.select { |workshop| !workshop.passed? }
	end

  def terms
  	render layout: 'additional'
  end

  def instagram
    InstagramFetcher.new.fetch(3.weeks.ago)
  end
end
