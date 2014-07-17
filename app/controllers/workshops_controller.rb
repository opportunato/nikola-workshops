class WorkshopsController < ApplicationController
 layout "workshop"

  def index
    @workshops = Workshop.for_admin.decorate

    render layout: false
  end

  def show
    @workshop = Workshop.find_by(id: params[:id]).decorate

    @has_close_button = (request.format == "js")

    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def create
    @workshop = Workshop.new(workshop_original_params)

    if @workshop.save && update_workshop
      render json: @workshop, status: :created
    else
      render json: @workshop.errors, status: :unprocessable_entity
    end
  end

  def update
    @workshop = Workshop.find(params[:id])

    if @workshop.update(workshop_original_params) && update_workshop
      render json: @workshop, status: :created
    else
      render json: @workshop.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @workshop = Workshop.find(params[:id])
    @workshop.destroy

    head :no_content
  end

private
  def workshop_params
    params.require(:workshop).permit(:title, :headline, :description, :program, :price, :buy_link, :start_date, :end_date, :is_published, 
      hosts: [:id, :name, :description, :link, :image_id],
      videos: [:id, :link],
      images: [:id]
    )
  end

  def update_workshop
    update_hosts(workshop_params[:hosts]) && update_videos(workshop_params[:videos]) && update_images(workshop_params[:images])
  end

  def workshop_original_params
    workshop_params.except(:hosts, :videos, :images)
  end

  # TODO oh, the humanity...
  # That sucks waaaaay to much cock

  def update_collection(collection, collection_name, constructor, create=true)
    old_collection = @workshop.send(collection_name)
    old_collection_ids = old_collection.map(&:id)
    new_collection_ids = collection.map { |element| element[:id] }

    old_collection.each do |element|
      if !new_collection_ids.include?(element.id)
        element.destroy
      end
    end

    collection.each do |element|

      # The horror is here

      if !old_collection_ids.include?(element[:id])
        if create
          object = constructor.new(element.except(:image_id))
          @workshop.send(collection_name).push object
        else
          @workshop.send(collection_name).push constructor.find_by(id: element[:id])
        end
      else
        object = constructor.find_by(id: element[:id])
        object.update(element.except(:id, :image_id))
      end

      # And here is really scary too

      if element[:image_id].present?
        image = HostImage.find_by(id: element[:image_id])
        object.image = image
      end
    end

    @workshop.save
  end

  def update_hosts(hosts)
    hosts ||= []
    update_collection(hosts, :hosts, Host)
  end

  def update_videos(videos)
    #Zakhar style coding

    videos ||= []
    update_collection(videos, :videos, WorkshopVideo)
  end

  def update_images(images)
    images ||= []
    update_collection(images, :images, WorkshopImage, false)
  end
end