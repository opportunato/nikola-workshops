class WorkshopVideoDecorator < ApplicationDecorator
  decorates :workshop_video
  delegate_all

  def player_link

  end
end