class ReportDecorator < ApplicationDecorator
  decorates :report
  decorates_association :videos
  delegate_all

  def media
    h.content_tag "ul" do
      model.videos.decorate.map do |video|
        h.content_tag("li", class: "pane") do
          video.player_link  
        end
      end.join.html_safe + 
      model.images.map do |image|
        h.content_tag("li", class: "pane") do
          h.content_tag "div", "", h.responsive_background_image(image.image).merge(class: "carousel-image bg")
        end
      end.join.html_safe
    end
  end

  def cover_image
    if model.images.count > 0
      model.images.first.image.url(:desktop)
    end
  end

  def first_paragraph
    first_paragraph = /<p>(.*?)<\/p>/.match(model.description)

    if first_paragraph
      h.strip_tags first_paragraph[1]
    end
  end
end