class StartpageController < ApplicationController
	def index
    @workshops = Workshop.for_startpage.decorate

    @passed_workshops = @workshops.select { |workshop| workshop.passed? }
    @current_workshops = @workshops.select { |workshop| !workshop.passed? }

    @feed_images = FeedImage.latest.limit(5)
  end

  def terms
  	render layout: 'additional'
  end

  def instagram
    @has_close_button = (request.format == "js")

    @feed_images = FeedImage.latest

    respond_to do |format|
      format.html { render layout: "workshop" }
      format.js { render layout: false }
    end
  end
end
