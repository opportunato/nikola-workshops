class WorkshopVideoDecorator < ApplicationDecorator
  decorates :workshop_video
  delegate_all

  def player_link
    player_link = model.player_link + "?badge=0&byline=0&color=21D1BF&portrait=0&title=0"
    h.content_tag 'iframe', "", allowfullscreen: "", frameborder: "0", mozallowfullscreen: "", webkitallowfullscreen: "", src: player_link
  end
end