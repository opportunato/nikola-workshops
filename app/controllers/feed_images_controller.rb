class FeedImagesController < ApplicationController
 layout "workshop"
 before_filter :admin_login

  def index
    @feed_images = FeedImage.all

    render layout: false
  end

  def destroy
    @feed_image = FeedImage.find(params[:id])
    @feed_image.destroy

    head :no_content
  end
end