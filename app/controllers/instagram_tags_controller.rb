class InstagramTagsController < ApplicationController
 layout "workshop"
 before_filter :admin_login

  def index
    @tags = InstagramTag.all

    render layout: false
  end

  def create
    @tag = InstagramTag.new(tag_params)

    if @tag.save
      render json: @tag, status: :created
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @tag = InstagramTag.find(params[:id])
    @tag.destroy

    head :no_content
  end

private
  
  def tag_params
    params.require(:tag).permit(:name)
  end
end