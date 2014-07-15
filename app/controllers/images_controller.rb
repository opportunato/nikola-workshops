class ImagesController < ApplicationController

  def create_for_host
    image = HostImage.create(image: params[:image])
    render json: { id: image.id, url: image.image.url(:small) }, layout: false
  end

  def create_for_workshop
    image = WorkshopImage.create(image: params[:image])
    render json: { id: image.id, url: image.image.url(:mobile) }, layout: false
  end
end