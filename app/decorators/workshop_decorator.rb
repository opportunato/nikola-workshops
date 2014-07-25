class WorkshopDecorator < ApplicationDecorator
  decorates :workshop
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
      model.images.first.image.url(:mobile)
    end
  end

  def description
    model.description.html_safe
  end

  def first_paragraph
    first_paragraph = /<p>(.*?)<\/p>/.match(model.description)

    if first_paragraph
      first_paragraph[1].html_safe
    end
  end

  def program
    model.program.html_safe
  end

  def formatted_price
    price = h.number_with_delimiter(model.price, delimiter: " ")

    if model.is_price_min
      t("common.min_roubles_cost", price: price)
    else
      t("common.roubles_cost", price: price)
    end
  end

  def duration
    duration = if start_date.month == end_date.month
      [
        start_date.day,
        "—",
        end_date.day,
        " ",
        t("date.common_month_names")[start_date.month]
      ].join
    else
      [
        start_date.day,
        " ",
        t("date.common_month_names")[start_date.month],
        "—",
        end_date.day,
        " ",
        t("date.common_month_names")[end_date.month]
      ].join
    end
  end 

end