class ReportsController < ApplicationController
 layout "workshop"
 before_filter :admin_login, except: :show

  def index
    @reports = Report.all

    render layout: false
  end

  def show
    @workshop = Workshop.friendly.find(params[:id]).decorate
    @object = @workshop.reports.where(slug: params[:slug]).first.decorate

    render template: "workshops/show"
  end

  def create
    @report = Report.new(report_original_params)

    if @report.save && update_report
      render json: @report, status: :created
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  def update
    @report = Report.find(params[:id])

    if @report.update(report_original_params) && update_report
      render json: @report, status: :ok
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    head :no_content
  end

private
  def report_params
    params.require(:report).permit(:workshop_id, :text, :is_published, :workshop_id, 
      author: [:name, :description, :link, :image_id],
      videos: [:id, :link],
      images: [:id]
    )
  end

  def update_report
    update_author(report_params[:author]) && update_videos(report_params[:videos]) && update_images(report_params[:images])
  end

  def report_original_params
    report_params.except(:author, :videos, :images)
  end

  # TODO oh, the humanity...
  # That sucks waaaaay to much cock

  def update_collection(collection, collection_name, constructor, create=true)
    old_collection = @report.send(collection_name)
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
          @report.send(collection_name).push object
        else
          @report.send(collection_name).push constructor.find_by(id: element[:id])
        end
      else
        object = constructor.find_by(id: element[:id])
        object.update(element.except(:id, :image_id))
      end
    end

    @report.save
  end

  def update_author(author)
    author = if @report.has_author?
      @report.author
    else
      Host.create(hostable: @report)
    end

    image_id = report_params[:author][:image_id]

    if image_id.present?
      image = HostImage.find_by(id: image_id)
      author.image = image
      author.save
    end

    author.update(report_params[:author].except(:image_id))
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